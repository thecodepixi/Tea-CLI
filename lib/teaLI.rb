require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def scrape_for_tea  
        scraper = Scraper.new 
        puts "created new scraper"
        scraper.get_tea_info
        puts "cool we're done scraping!"
    end 

end 

tea_CLI = TeaLI.new 
tea_CLI.scrape_for_tea 
coconut_tea = Tea.find_by_ingredient("coconut")
coconut_tea.each { |tea| puts tea.name }