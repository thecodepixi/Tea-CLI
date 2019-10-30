require_relative './scraper.rb'

require 'pry'

class TeaLI
    attr_accessor :scraper 

    def initialize
        self.scrape_for_tea
    end 
   
    def scrape_for_tea  
        puts "Loading the TeaLI. Please wait..."
        @scraper = Scraper.new 
        @scraper.get_teas
    end 

    def titleize(word)
        title = word.split.map(&:capitalize).join(' ')
        title
    end 

    def display_categories
        puts "Here are all of our available varieties: "
        puts " "
        Category.all.each_with_index do |category, index|
            puts "  #{index+1}. #{category.name}"
        end 
    end  
    
    def display_tea_info(tea_name)
        tea = Tea.find_by_name(tea_name)
        puts " "
        puts "Here are the details for our #{titleize(tea[0].name)} Tea"
        puts "- - - - - - - - - - - - - - - "
        puts "  Description: "
        puts "      #{tea[0].description}"
        puts " "
        puts "  Ingredients: "
        puts "      This tea is #{tea[0].ingredients}"
        puts " "
        puts "  Purchasing Options: "
        tea[0].pricing.each do |size, price|
            puts "      #{size.capitalize}: #{price}"
        end 
        puts "- - - - - - - - - - - - - - - "
    end 
    
    def display_category_teas(category)
        category_teas = Tea.all_teas_in(category)
        puts "Here are all of our #{category}: "
        category_teas.each_with_index do |tea, index|
            puts "  #{index+1}. #{titleize(tea.name)}"
        end 
    end 

    def info_for_one_tea(tea)
        @scraper.get_this_teas_info(tea)
    end 

    def start_options 
        puts " "
        puts "Welcome to the TeaLI! A CLI for finding teas you never knew you needed..."
        puts "- - - - - - - - - - - - - - - "
        puts "How would you like to search for tea?"
        puts " "
        puts "1. See all available varieties."
        puts " "
        puts "2. Search by a specific ingredient."
        puts " "
        puts "3. Surprise me with a random tea!"
        puts " "
        puts "Type 1, 2, or 3 and press ENTER." 
        puts " "
        puts "When you are done using the TeaLI, just type EXIT and press ENTER."
        puts "- - - - - - - - - - - - - - - "
    end 

    def surprise_tea 
        surprise = Tea.get_random_tea 
        @scraper.get_this_teas_info(surprise)
        puts "SURPRISE! You got #{titleize(surprise)} Tea!"
        self.display_tea_info(surprise)
    end 

    def 

    def call 
       start_options



    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.display_options 

