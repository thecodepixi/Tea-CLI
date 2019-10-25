require-relative "../lib/scraper.rb"
require-relative "../lib/category.rb" 

require 'pry'
require 'nokogiri'
require 'open-uri'

class Tea 
    
    attr_reader :name
    attr_accessor :url, :ingredients, :description, :pricing
    @@all = [] 

    def initialize(name)
        @name 
        @@all << self 
        self.ingredients = [] 
        self.pricing = {} 
    end 

end 