# -*- coding: utf-8 -*-
require 'active_record'
require './scraping.rb'
ActiveRecord::Base.establish_connection(
   		"adapter" => "sqlite3",
   		"database" => "./model/users.db"
)
class Lesson < ActiveRecord::Base
#lesson nameの最後に\n入ってる
#
#
#
#

end
class User < ActiveRecord::Base

end

s= Scrape.new()
s.todayKyuko.each do |cl|
	
	classes = Lesson.find_by(lesson_name: "○#{cl.sub("\n","")}")
	if classes != nil then
		puts classes.teacher.gsub("\n","")
	end
end