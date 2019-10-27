require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def scrape_for_tea  
        scraper = Scraper.new 
        puts "created new scraper"
        scraper.get_teas
        puts "cool we're done scraping!"
    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.scrape_for_tea 
