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
        self.description = ""
        self.ingredients = "" 
        self.pricing = {} 
    end 

    def self.all 
        @@all
    end 

    def self.find_by_name(name)
        @@all.detect {|tea| tea.name == name}
    end 

    # checks whether or not we've already scraped the info about this particular tea object
    # returns true if tea info has already been acquired
    def check_for_tea_info
        self.ingredients.length > 0 && self.description.length > 0 && self.pricing.length > 0 
    end 

    def self.all_teas_in(tea_category)
        @@all.select {|tea| tea.category.name == tea_category}
    end 

    def self.find_by_ingredient(ingredient)
        @@all.select { |tea| tea.ingredients.include?(ingredient) } 
    end 

    def self.get_random_tea
        rand_tea  = Tea.all.sample 
        rand_tea.name 
    end 

end 

