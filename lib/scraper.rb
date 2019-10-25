require_relative "./category.rb"
require_relative "./tea.rb"

require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    def get_page(url)
        page = Nokogiri::HTML(open(url))
        page
    end 

    def get_categories
        page = get_page("https://www.adagio.com/list/best_sellers.html")
        page.css("div#accountNav.marginLeft.categoryLeft div.hide_768").each do |category|
            if category.values != ["breakVerySmall hide_768"] && category.css("a").text != "Advanced Search"
            category_name = category.css("a").text
            category_url = category.css("a").attribute("href").value
            new_category = Category.new(category_name)
            new_category.url = "https://www.adagio.com#{category_url}"
            end 
        end 
    end 

    def get_teas
        Category.all.each do |category|
            page = get_page(category.url)
            page.css("div.productIndexParent").each do |product|
                new_tea = Tea.new(product.css("h6").text)
                new_tea.url = "https://www.adagio.com" + product.css("a").attribute("href").value
                binding.pry 
                new_tea.category = category 
                category.teas << new_tea 
            end 
        end 
    end 

end

scraper = Scraper.new 
scraper.get_categories 
scraper.get_teas 

