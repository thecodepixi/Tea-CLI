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
        self.all.select {|tea| tea.name == name}
    end 

    def self.find_or_create_by_name(name)
        if !self.all.select {|tea| tea.name == name}
            self.all.select {|tea| tea.name == name}
        else 
            Tea.new(name)
        end 
    end 

end 