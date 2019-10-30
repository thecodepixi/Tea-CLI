require_relative './scraper.rb'

require 'pry'

class TeaLI
    attr_accessor :scraper 

    def initialize
        self.scrape_for_tea
    end 
   
    def scrape_for_tea  
        puts "Loading your TeaLI session. Please wait..."
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
        puts "Which type of teas would you like to see?"
        puts "(Ex: Type 'Black Teas' and press ENTER) "
        puts "(to go back type 'back' and press ENTER)"
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
        if tea[0].ingredients.length > 0 
            puts "      This tea is #{tea[0].ingredients}"
        else 
            puts "      This is a single origin (non-blended) tea."
        end 
        puts " "
        puts "  Purchasing Options: "
        tea[0].pricing.each do |size, price|
            puts "      #{size.capitalize}: #{price}"
        end 
        puts "- - - - - - - - - - - - - - - "
    end 
    
    def display_category_teas(category)
        category_name = titleize(category)
        category_teas = Tea.all_teas_in(category_name)
        puts "Here are all of our #{category}: "
        category_teas.each_with_index do |tea, index|
            puts "  #{index+1}. #{titleize(tea.name)}"
        end 
        puts " "
        puts "Which tea would you like to know more about?"
        puts "(to go back type 'back' and press ENTER)"
        puts " "
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
        puts "1. See all available tea types."
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

    def run_categories
        display_categories

        user_input = gets.chomp 

        while user_input.downcase != 'exit' 

            if user_input.downcase == 'back'
                call 
            end 

            display_category_teas(user_input)
            
            user_input = gets.chomp 

            if user_input.downcase == 'back'
                run_categories 
            end 

            info_for_one_tea(user_input.downcase)

            display_tea_info(user_input.downcase)

            puts "to go back to the main menu, type 'back' and hit ENTER"
            puts "or to exit, type 'exit' and hit enter" 
        
            user_input = gets.chomp 

            if user_input.downcase == 'back'
                call 
            end 

        end 

        goodbye 
        
    end 

    def call 
        start_options
        user_input = gets.chomp 
        while user_input.downcase != 'exit'
            if user_input.to_i == 1 
                run_categories
            end 
        end 

        goodbye 

    end 

    def goodbye 
        puts " "
        puts "Thanks for using TeaLI! Happy Sipping!"
        puts " "
    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.call 

