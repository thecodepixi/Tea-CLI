require_relative "../config/env"

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

    def self.check_for_category(category_name)
        self.all.detect { |cat| cat.name == category_name }
    end 

end 
