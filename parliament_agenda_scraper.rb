#!/usr/bin/env ruby
# encoding: utf-8

# things to put into votes.parliament.ge
# parliament agenda scraper
# world bank grant (can 
# parliament speech/verbatm/stenography transcripts

# data: date (day, month, year, time), title, body, location

require "nokogiri"
require "open-uri"



def month_to_int(mstring)
  months = { იანვარი: 1,
             თებერვალი: 2,
             მარტი: 3,
             აპრილი: 4,
             მაისი: 5,
             ივნისი: 6,
             ივლისი: 7,
             აგვისტო: 8,
             სექტემბერი: 9,
             ოქტომბერი: 10,
             ნოემბერი: 11,
             დეკემბერი: 12 }
             
  return months[mstring.to_sym]
end

url = "http://parliament.ge/index.php?option=com_content&view=category&layout=blog&id=59&Itemid=520&lang=ge"

page = Nokogiri::HTML(open(url).read)

days = page.css('table.blog > tr')


string_day = days[0].css("td.contentheading").text.chomp

day_string = string_day.scan(/\d+/)
month_string = string_day.scan(/\D+/).join.gsub(' ', '').strip
year_string = Time.now.year

string_time = days[0].css('strong')



days.each do |day|
  
end
