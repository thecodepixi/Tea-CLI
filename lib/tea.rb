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

    def self.find_by_name(name)
        @@all.select {|tea| tea.name == name}
    end 

    def self.all_teas_in(tea_category)
        @@all.select {|tea| tea.category.name == tea_category}
    end 

end 