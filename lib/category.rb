require-relative "../lib/scraper.rb"
require-relative "../lib/tea.rb" 

require 'pry'
require 'nokogiri'
require 'open-uri'

class Category
    
    attr_reader @name 
    attr_accessor @url 
    @@all = [] 

    def initialize(name)
        @name = name
        @@all << self 
    end 

end 
