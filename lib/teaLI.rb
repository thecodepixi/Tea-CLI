require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def scrape_for_tea  
        puts "Please wait while we gather all the tea info!"
        scraper = Scraper.new 
        scraper.get_teas
    end 

    def display_categories
        Category.all.each_with_index do |category, index|
            puts "#{index+1}. #{category.name}"
        end 
    end     

end 

tea_CLI = TeaLI.new 
tea_CLI.scrape_for_tea 
tea_CLI.display_categories