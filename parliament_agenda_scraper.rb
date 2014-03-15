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

url = ARGV[0] || "http://parliament.ge/index.php?option=com_content&view=category&layout=blog&id=59&Itemid=520&lang=ge"
page = Nokogiri::HTML(open(url).read)
days = page.css('table.blog > tr')

days.each do |day|

  # get date
  
  string_day = day.css("td.contentheading").text.strip unless day.css("td.contentheading").nil?
  day_string = string_day.scan(/\d+/).first
  month_string = string_day.scan(/\D+/).join.gsub(' ', '').strip
  year_string = Time.now.year
  time_string = day.css('table')[1].css('strong')[0].text[0,5] unless day.css('table')[1].nil? || day.css('table')[1].css('strong')[0].nil?
  hour_string, minute_string = time_string.split(':') unless time_string.nil?
  date = DateTime.new(year_string.to_i, month_to_int(month_string), day_string.to_i, hour_string.to_i, minute_string.to_i, 0, '+3') if day_string && month_string && year_string && time_string && hour_string
  
  # get title
  
  title_string = day.css('table')[1].css('strong')[0].text
  
  
end
