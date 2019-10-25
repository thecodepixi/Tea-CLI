require-relative "./lib/tea.rb"
require-relative "./lib/category.rb"
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    def get_page 
        page = Nokogiri::HTML(open("https://www.adagio.com/list/best_sellers.html"))
        page
    end 

    def get_categories
        get_page.css("div#accountNav.marginLeft.categoryLeft div.hide_768").each_with_index do |category, index|
           tea_name = tea.css("a").text
           tea_url = tea.css("a").attribute("href").value 
           binding.pry 
           category = Category.new(tea_name)
           category.url = tea_url 
        end 
    end 
end

Scraper.new.get_categories 
