# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'twitter'# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'active_record'

class Scrape

	def syllabus(classCode)
		agent = Mechanize.new
		for num in 1..906 do
			page = agent.get('https://syllabus.doshisha.ac.jp/index.php')
			search_page = page.form_with(:action => './lectureWebResult.php') do |form|
			end.submit
			#search_page = Nokogiri::HTML(search_page.content.toutf8).xpath('/html/body/table[2]/tbody/tr/td/table').css('tr')
			agent.page.link_with(:value =>'次結果一覧/Next').click
			p agent.page
			search_page = page.form_with(:name => 'form2') do |form|
				form.field_with(:name =>'clicknumber').value = '#{num}'
				search_page = Nokogiri::HTML(search_page.content.toutf8).xpath('/html/body/table[2]/tbody/tr/td/table').css('tr')
				search_page.each do |data|
					lesson_id = data.css('td')[0].inner_text().to_s
					lesson_name = data.css('td')[2].xpath('a/text()')[0].inner_text().to_s
					teacher = data.css('td')[3].inner_text().to_s
					campus = data.css('td')[4].inner_text().to_s
					Lesson.create(lesson_id:lesson_id,lesson_name:lesson_name, teacher:teacher,campus:campus )
				end
			end.submit
			
		end
	end
end

ActiveRecord::Base.establish_connection(
   		"adapter" => "sqlite3",
   		"database" => "./model/users.db"
)
class Lesson < ActiveRecord::Base
end
class User < ActiveRecord::Base
end

s= Scrape.new()


 s.syllabus('')
 #/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[3]/a/text()[1]