require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def run 
        scraper = Scraper.new 
        puts "created new scraper"
        scraper.get_tea_info 
        puts "cool we're done scraping!"
        chosen_tea = Tea.all.select {|tea| tea.name == "white symphony"}
        puts chosen_tea.name 
    end 
end 

tea_CLI = TeaLI.new 
tea_CLI.run 
