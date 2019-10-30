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
            if category.values != ["breakVerySmall hide_768"] && category.css("a").text != "Advanced Search" && Category.all.length < 10 
            category_name = category.css("a").text
            category_url = category.css("a").attribute("href").value
            new_category = Category.new(category_name)
            new_category.url = "https://www.adagio.com#{category_url}"
            end 
        end 
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
        end 
    end 

    def get_tea_info(tea)
            page = get_page(tea.url)
            tea.description = page.css("div.description div").text.split(' | ')[0] + "."
            tea.ingredients = page.css("h5.titlepadding.contentTitleItalics").text
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
                # this checks for out of stock or unavailable 
                if price.css("div.notifyMe").text == "NOTIFY ME" || item_price == ""
                    tea.pricing[trimmed_item_size] = "out of stock"
                elsif item_price.to_i >= 1 && item_price != "" 
                    tea.pricing[trimmed_item_size] = "$" + item_price
                end 
            end  
    end 

    def get_this_teas_info(tea_name)
        # when we only need info about a single tea 
        # utilize check_for_tea_info and find_by_name here 
        tea = Tea.find_by_name(tea_name)
        if !tea[0].check_for_tea_info 
            get_tea_info(tea[0])
        end 
    end 

    def get_all_tea_info
        Tea.all.each do |tea|
            if !tea.check_for_tea_info 
                get_tea_info(tea)
            end
        end 
    end 

end

