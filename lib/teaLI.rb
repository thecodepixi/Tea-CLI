require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def scrape_for_tea  
        puts "Please wait while we gather all the tea info!"
        scraper = Scraper.new 
        scraper.get_teas
    end 

    def display_categories
        puts "Here are all of our available varieties: "
        Category.all.each_with_index do |category, index|
            puts "  #{index+1}. #{category.name}"
        end 
    end   
    
    def display_category_teas(category)
        category_teas = Tea.all_teas_in(category)
        puts "Here are all of our #{category}: "
        category_teas.each_with_index do |tea, index|
            tea_title = tea.name.split.map(&:capitalize).join(' ')
            puts "  #{index+1}. #{tea_title}"
        end 
    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.scrape_for_tea 
tea_CLI.display_category_teas("Black Teas")