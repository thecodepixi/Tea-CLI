require_relative '../config/env.rb'

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
    end  
    
    def display_tea_info(tea_name)
        tea = Tea.find_by_name(tea_name)
            puts " "
            puts "Here are the details for our #{titleize(tea.name)} Tea"
            puts "- - - - - - - - - - - - - - - "
            puts "  Description: "
            puts "      #{tea.description}"
            puts " "
            puts "  Ingredients: "
            if tea.ingredients.length > 0 
                puts "      This tea is #{tea.ingredients}"
            else 
                puts "      This is a single origin (non-blended) tea."
            end 
            puts " "
            puts "  Purchasing Options: "
            tea.pricing.each do |size, price|
                puts "      #{size.capitalize}: #{price}"
            end 
    end 
    
    def display_category_teas(category)
        category_name = titleize(category)
        category_teas = Tea.all_teas_in(category_name)
        if category_teas.length > 0 
            puts "Here are all of our #{category}: "
            category_teas.each_with_index do |tea, index|
                puts "  #{index+1}. #{titleize(tea.name)}"
            end 
        else
            puts "Sorry that doesn't appear to be a valid category..."
            display_categories
        end 
    end 

    def info_for_one_tea(tea)
        @scraper.get_this_teas_info(tea)
    end 

    def menu_options 
        puts "1. See all available tea types."
        puts " "
        puts "2. Search by a specific ingredient."
        puts " "
        puts "3. Surprise me with a random tea!"
        puts " "
        puts "Type 1, 2, or 3 and press ENTER." 
        puts " "
        puts "If you are done using the TeaLI, just type EXIT and press ENTER."
        puts "- - - - - - - - - - - - - - - "
    end 

    def surprise_tea 
        surprise = Tea.get_random_tea 
        @scraper.get_this_teas_info(surprise)
        puts "SURPRISE! You got #{titleize(surprise)} Tea!"
        self.display_tea_info(surprise)
    end 

    def run_categories
        input = nil 

            display_categories
            puts "Which type of teas would you like to see?"
            puts "(Ex: Type 'Black Teas' and press ENTER) "
            puts " "
            puts "(to go back type 'back' and press ENTER)"
            puts " "

            input = gets.strip.downcase 

            if Category.check_for_category(titleize(input))
                display_category_teas(titleize(input))
                puts " "
                puts "Which tea would you like to know more about? (just type its name and press ENTER)"
                puts "(to go back type 'back' and press ENTER)"
                puts " "

                input = gets.strip.downcase
                
                if input == 'back'
                    run_categories
                else 
                    tea = Tea.find_by_name(input)
                    if tea != nil 
                        info_for_one_tea(tea.name)
                        display_tea_info(tea.name)
                    else 
                        puts " "
                        puts "Bummer! It looks like that isn't a valid tea name."
                        puts " "
                    end     
                end 
            elsif input == 'back'
                return 
            elsif !Category.all.include?(titleize(input)) && input != 'back'
                puts "Sorry, please choose a valid tea type!"
                puts " "
                run_categories
            end 
    end     

    def run_all_info_search 
        puts " "
        puts "Great! Please wait while we gather some information. This will take about 60 seconds..."
        puts " "
        @scraper.get_all_tea_info
        puts " "
        puts "Thanks for waiting!"
    end 

    def run_ingredient_search
        puts " "
        puts "What ingredient are you looking for?" 
        puts "(to go back, please type 'back' and press ENTER)"
        user_input = nil
        user_input = gets.strip.downcase
            if user_input == 'back'
                return 
            else 
                teas = Tea.find_by_ingredient(user_input)
                if teas.length > 0 
                    puts " "
                    puts "Here are all the teas we have that contain #{user_input}"
                    puts " "
                        teas.each_with_index do |tea, index|
                            puts "#{index+1}. #{titleize(tea.name)}"
                        end 
                    puts " "
                    puts "Which tea would you like to know more about? (just type its name and press ENTER)"
                    puts "or type 'back' to search for a different ingredient..."
                    user_input = gets.strip.downcase
                    if user_input == 'back'
                        run_ingredient_search
                    else 
                        tea = Tea.find_by_name(user_input)
                        if tea == nil 
                            puts "Sorry, it looks like that's not a valid tea choice, try again!"
                            run_ingredient_search
                        else 
                            display_tea_info(user_input)
                        end 
                    end 
                else 
                    puts "Sorry, it looks like we don't carry any teas with that ingredient"
                    run_ingredient_search
                end 
            end 
    end 

    def call 
        puts " "
        puts "Welcome to the TeaLI! A CLI for finding teas you never knew you needed..."
        user_input = nil
        until user_input == 'exit'
            puts "- - - - - - - - - - - - - - - "
            puts "What would you like to do?"
            puts " "
            menu_options 
            user_input = gets.strip.downcase
            if user_input.to_i == 1 
                run_categories
            elsif user_input.to_i == 2 
                run_all_info_search
                run_ingredient_search
            elsif user_input.to_i == 3 
                surprise_tea 
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

TeaLI.new.call 

