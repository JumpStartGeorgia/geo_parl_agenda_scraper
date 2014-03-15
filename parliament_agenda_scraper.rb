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
  1 + %w[ იანვარი თებერვალი მარტი აპრილი მაისი ივნისი ივლისი აგვისტო სექტემბერი ოქტომბერი ნოემბერი დეკემბერი ].index(mstring)
end

def parse_date_time(string_day, time_string)
  day_string, month_string = string_day.strip.scan(/(\d+)\s?(\D+)/).flatten
  hour, minute = time_string.split(':').map(&:to_i)
  DateTime.new(Time.now.year, month_to_int(month_string), day_string.to_i, hour, minute, 0, '+3')
end

url = ARGV[0] || "http://parliament.ge/index.php?option=com_content&view=category&layout=blog&id=59&Itemid=520&lang=ge"

timestamp = Time.now.strftime('%Y-%m-%d-%H:%M')

open("data/#{timestamp}.html", "wb") do |file|
  open(url) do |uri|
     file.write(uri.read)
  end
end

page = Nokogiri::HTML(open(url).read)
days = page.xpath('//td[@class="contentheading"]')

days.each do |day|
  time_cell = day.xpath('../../..//td[@colspan=2]')
  time, title =  time_cell.css('p').first.css('strong').first.text.split ' - '
  date = parse_date_time(day.text, time)
  location = time_cell.css('p em').text.scan(/N\d+/).first
  puts "Date: #{date} // Title: #{title} // Location: #{location}"
end
