# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'twitter'
class Scrape

	def todayKyuko
		@kyukolist =[]
		Nokogiri::HTML(open('https://duet.doshisha.ac.jp/kokai/html/fi/fi050/FI05001G.html')).xpath('//tr/td[2]').each do |classname|
			@kyukolist << classname.to_s.gsub(/<\/td>|<td>/,"")
		end
		@kyukolist
	end

	def tommolowKyuko
		@kyukolist =[]
			Nokogiri::HTML(open('https://duet.doshisha.ac.jp/kokai/html/fi/fi050/FI05001G_02.html')).xpath('//tr/td[2]').each do |classname|
			@kyukolist << classname.to_s.gsub(/<\/td>|<td>/,"")
		end
		@kyukolist
	end
end
