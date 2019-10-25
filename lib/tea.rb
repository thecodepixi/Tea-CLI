require_relative "./category.rb"

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

    def self.all 
        @@all
    end 

end 