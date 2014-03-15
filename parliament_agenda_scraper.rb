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
             
  return months[mstring.gsub(' ','').to_sym]
end

def parse_date_time(string_day, time_string)
  day_string, month_string = string_day.strip.scan(/(\d+)\s?(\D+)/).flatten
  hour, minute = time_string.split(':').map(&:to_i)
  DateTime.new(Time.now.year, month_to_int(month_string), day_string.to_i, hour, minute, 0, '+3')
end

url = ARGV[0] || "http://parliament.ge/index.php?option=com_content&view=category&layout=blog&id=59&Itemid=520&lang=ge"

day 

File.open('data/')
  File.open(url).read

page = Nokogiri::HTML(open(url).read)
days = page.xpath('//td[@class="contentheading"]')

count = 1
days.each do |day|
  time_cell = day.xpath('../../..//td[@colspan=2]')
  date = parse_date_time(
    day.text,
    time_cell.css('p').first.css('strong').first.text[0,5]
  )
  puts date
end
