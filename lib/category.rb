require_relative "./tea.rb"

require 'pry'
require 'nokogiri'
require 'open-uri'

class Category

    attr_reader :name 
    attr_accessor :url, :teas 
    @@all = [] 

    def initialize(name)
        @name = name
        @teas = [] 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

end 
