require_relative './scraper.rb'

require 'pry'

class TeaLI
    
    def run 
        scraper = Scraper.new 
        scraper.get_tea_info 
    end 
end 

tea_CLI = TeaLI.new 
tea_CLI.run 