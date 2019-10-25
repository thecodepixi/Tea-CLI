require_relative "./category.rb"

require 'pry'
require 'nokogiri'
require 'open-uri'

class Tea 

    attr_reader :name
    attr_accessor :url, :ingredients, :description, :pricing, :category 
    @@all = [] 

    def initialize(name)
        @name = name
        @@all << self 
        self.ingredients = [] 
        self.pricing = {} 
    end 

    def self.all 
        @@all
    end 

    def self.all_teas_in(category)
        self.all.select { |tea| binding.pry }
    end 

end 