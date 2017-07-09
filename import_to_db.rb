# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'active_record'

class Scrape

	def syllabus(classCode)
		agent = Mechanize.new
		agent.get('https://syllabus.doshisha.ac.jp/index.php')
		search_page = agent.page.form_with(:action => './lectureWebResult.php') do |form|
			form.field_with(:name => 'maxdisplaynumber').value = '1000'
		end.submit
		for num in 1..19 do
			agent.page.form_with(:name =>'form2') do |form|
				#form.click_button(form.button_with(:value => '次結果一覧/Next')) 
				form.field_with(:name => 'clicknumber').value = num.to_s
				form.click_button(form.button_with(:value => '送信'))
				search_page = Nokogiri::HTML(agent.page.content.toutf8).xpath('/html/body/table[2]/tbody/tr/td/table').css('tr')
				search_page.each do |data|
					if data.css('td')[1].inner_text().to_s == "学部 " then
						lesson_id = data.css('td')[0].inner_text().to_s.sub(/○|△/,"").rstrip
						lesson_name = data.css('td')[2].xpath('a/text()')[0].inner_text().to_s
						teacher = data.css('td')[3].inner_text().to_s.gsub("  "," ")
						campus = data.css('td')[4].inner_text().to_s
						Lesson.create(lesson_id:lesson_id,lesson_name:lesson_name, teacher:teacher,campus:campus)
						p lesson_id
						p lesson_name
					end
				end
			end	
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