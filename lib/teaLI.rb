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
        if category_teas.length > 0 
            puts "Here are all of our #{category}: "
            category_teas.each_with_index do |tea, index|
                puts "  #{index+1}. #{titleize(tea.name)}"
            end 
            puts " "
            puts "Which tea would you like to know more about?"
            puts "(to go back type 'back' and press ENTER)"
            puts " "
        else
            puts "Sorry that doesn't appear to be a valid category..."
            display_categories
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

        end_of_method_options
        
    end 

    def run_all_info_search 
        puts " "
        puts "Great! Please wait while we gather some information. This will take less than 60 seconds..."
        puts " "
        @scraper.get_all_tea_info
        puts " "
        puts "Thanks for waiting!"
    end 

    def run_ingredient_search
        puts " "
        puts "What ingredient are you looking for?" 
        puts "(to go back, please type 'back' and press ENTER)"
        user_input = ''
        user_input = gets.chomp 
            if user_input.downcase == 'back'
                call 
            else 
                teas = Tea.find_by_ingredient(user_input.downcase)
                if teas.length > 0 
                    puts " "
                    puts "Here are all the teas we have that contain #{user_input.downcase}"
                    puts " "
                        teas.each_with_index do |tea, index|
                            puts "#{index+1}. #{titleize(tea.name)}"
                        end 
                    puts " "
                    puts "Which tea would you like to know more about? (just type its name and press ENTER)"
                    puts "or type 'Back' to search for a different ingredient..."
                    user_input = gets.chomp 
                    if user_input.downcase == 'back'
                        run_ingredient_search
                    else 
                        display_tea_info(user_input.downcase)
                    end 
                else 
                    puts "Sorry, it looks like we don't carry any teas with that ingredient"
                    run_ingredient_search
                end 
            end 
        end_of_method_options
    end 

    def end_of_method_options 
        puts "Now what would you like to do?"
        puts " "
        puts "To return to the main menu, type 'menu'"
        puts "To exit, type 'exit'"
        puts "Press ENTER after typing your selection..."
        
        user_input = gets.chomp 

        while user_input.downcase != 'exit' 
            if user_input.downcase == 'menu'
                call 
            elsif user_input != 'menu' && user_input != 'exit' 
                puts "Please choose a valid option..."
                end_of_method_options 
            end 
        end 
    end 

    def call 
        start_options
        user_input = gets.chomp 
        while user_input.downcase != 'exit'
            if user_input.to_i == 1 
                run_categories
            elsif user_input.to_i == 2 
               run_all_info_search
               run_ingredient_search
            else 
                puts "oops, that's not a valid option!"
                call 
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

