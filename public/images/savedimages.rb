#!/usr/bin/env ruby

# usage: saveimages.rb <url>
# locally save all images from a web site

require 'nokogiri'
require 'open-uri'

exit if ARGV[0].nil?

doc = Nokogiri::HTML(open ARGV[0])

images = doc.xpath('//img').to_a.reject! do |img|
  url = img.attr('src')
  # ignore images unless they're png, gif, or jpeg
  # and ignore any images from quantserve
  not url.match(/(png|gif|jpe?g)$/i) or url.match(/quantserve/)
end

images.each do |img|
  url      = img.attr('src')
  filename = File.basename(url)

  open(filename, 'wb') do |file|
    puts "writing #{url} to #{filename}"
    file << open(url).read
  end
end