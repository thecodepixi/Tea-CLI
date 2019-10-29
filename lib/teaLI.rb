require_relative './scraper.rb'

require 'pry'

class TeaLI
    attr_accessor :scraper 

    def initialize
        self.scrape_for_tea
    end 
   
    def scrape_for_tea  
        puts "Please wait while we gather all the tea info!"
        @scraper = Scraper.new 
        @scraper.get_teas
    end 

    def titleize_name(tea)
        title = tea.name.split.map(&:capitalize).join(' ')
        title
    end 

    def display_categories
        puts "Here are all of our available varieties: "
        Category.all.each_with_index do |category, index|
            puts "  #{index+1}. #{category.name}"
        end 
    end  
    
    def display_tea_info(tea_name)
        tea = Tea.find_by_name(tea_name)
        puts "Here are the details for our #{titleize_name(tea[0])} Tea"
        puts "Description: "
        puts "  #{tea[0].description}"
        puts "Ingredients: "
        puts "  #{tea[0].ingredients.capitalize}"
        puts "Availability: "
        tea[0].pricing.each do |size, price|
            puts "  #{size.capitalize}: #{price}"
        end 
    end 
    
    def display_category_teas(category)
        category_teas = Tea.all_teas_in(category)
        puts "Here are all of our #{category}: "
        category_teas.each_with_index do |tea, index|
            puts "  #{index+1}. #{titleize_name(tea)}"
        end 
    end 

    def info_for_one_tea(tea)
        @scraper.get_this_teas_info(tea)
    end 

    def display_options 
        puts "How would you like to search for tea?"
        puts "1. See all available varieties."
        puts "2. Search by a specific ingredient."
        puts "3. Surprise me with a random tea!"
        puts "Type 1, 2, or 3 and press 'Enter'." 
    end 

    def surprise_tea 
        surprise = Tea.get_random_tea 
        @scraper.get_this_teas_info(surprise)
        puts "SURPRISE! You got #{surprise.capitalize}"
        self.display_tea_info(surprise)
    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.surprise_tea

