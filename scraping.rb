# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'twitter'
require 'mechanize'

class Scrape
	tomorrow_kyuko = Nokogiri::HTML(open('https://duet.doshisha.ac.jp/kokai/html/fi/fi050/FI05001G_02.html'))
	def syllabus(classCode)
		agent = Mechanize.new
		page = agent.get('https://syllabus.doshisha.ac.jp/index.php')
		search_page = page.form_with(:action => './lectureWebResult.php') do |form|
			form.keyword = classCode
		end.submit
		search_page = Nokogiri::HTML(search_page.content.toutf8).xpath('//td[3]/a/text()[1]').inner_text().sub(/○|△/,"")#最初の学期記号を消すため
	end

	def todayKyuko
		@kyukolist =[]
		Nokogiri::HTML(open('https://duet.doshisha.ac.jp/kokai/html/fi/fi050/FI05001G.html')).xpath('//tr/td[2]').each do |classname|
			@kyukolist << classname.to_s.gsub(/<\/td>|<td>/,"")
		end
		@kyukolist
	end
end

s= Scrape.new()

s.todayKyuko.each do |kyuko|
	puts kyuko
if s.syllabus('0270409-051').to_s ==  kyuko then
	puts "aruyoo"
end
	puts s.syllabus('0270409-051')

end