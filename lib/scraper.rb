require_relative "./category.rb"
require_relative "./tea.rb"

require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    puts "started reading scarper"

    def get_page(url)
        page = Nokogiri::HTML(open(url))
        page
    end 

    def get_categories
        page = get_page("https://www.adagio.com/list/best_sellers.html")
        page.css("div#accountNav.marginLeft.categoryLeft div.hide_768").each do |category|
            if category.values != ["breakVerySmall hide_768"] && category.css("a").text != "Advanced Search" && Category.all.length < 11 
            category_name = category.css("a").text
            category_url = category.css("a").attribute("href").value
            new_category = Category.new(category_name)
            new_category.url = "https://www.adagio.com#{category_url}"
            end 
        end 
        puts "got categories"
        binding.pry 
    end 

    def get_teas
        get_categories 
        Category.all.each do |category|
            page = get_page(category.url)
                page.css("div.productIndexParent").each do |product|
                    if category.teas.length < 10 
                    new_tea = Tea.new(product.css("h6").text)
                    new_tea.url = "https://www.adagio.com" + product.css("a").attribute("href").value
                    new_tea.category = category 
                    category.teas << new_tea 
                    end 
                end 
            puts "finished getting #{category.name}" 
        end 
        puts "got tea" 
    end 

    def get_tea_info 
        get_teas 
        Tea.all.each do |tea|
            page = get_page(tea.url)
            tea.description = page.css("div.description div").text.split(' | ')[0] + "."
            tea.ingredients = page.css("h5.titlepadding.contentTitleItalics").text
            # need to target different class (more specific). this grabs additional items not in block.
            page.css("div#pricesDiv.pricesList div.itemBlock").each do |price|
                item_size = price.css("div.size").text
                item_size_array = item_size.split(/\W/)
                item_size_array.map do |int| 
                    if int == ""
                        item_size_array.delete(int)
                    end 
                end 
                trimmed_item_size = item_size_array.join(" ")
                weird_price = price.css("div.price").text 
                item_price = weird_price.split(/\W/).last
                # this doesn't work for out of stock items. Need to figure out exactly what to check for and where. 
                if price.css("div.notifyMe").text == "NOTIFY ME" || item_price == ""
                    tea.pricing[trimmed_item_size] = "unavailable"
                elsif item_price.to_i >= 1 && item_price != "" 
                    tea.pricing[trimmed_item_size] = "$" + item_price
                end 
            end  
            puts "finished getting #{tea.name} tea info"
            puts "tea options = #{tea.pricing}"
        end 
        puts "got ALL THE TEA info (lol)"
    end 

    puts "finished reading scraper"
end

