require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def scrape_for_tea  
        puts "Please wait while we gather all the tea info!"
        scraper = Scraper.new 
        scraper.get_tea_info
    end 

    def start_program

    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.scrape_for_tea 