# dummy data to pass into tea and teaLI class methods 
require_relative './lib/tea.rb'

def create_some_tea 
    # irish breakfast 
    tea = Tea.new("irish breakfast")
    tea.url = "https://www.adagio.com/black/irish_breakfast.html"
    tea.description = "Our Irish Breakfast combines hearty black teas from Ceylon (Sri Lanka) and Assam (India) to get your morning off to a bright start. As its name implies, the Irish Breakfast black tea blend is an ideal accompaniment to a morning meal. It seamlessly blends the citrusy notes of a high-grown Ceylon with the malty underscore of a pungent Assam. Spicy and jammy aroma on the leaf, malty and deep flavor with a brisk and 'buzzy' mouthfeel. Rounded sweetness in the finish. May be enjoyed plain or with a drop of milk. Irish Breakfast is one of Adagio's most popular teas."
    tea.ingredients = "Ceylon Sonata Tea & Assam Melody Tea"
    tea.pricing = {"sample" => "$2", "3oz" => "$8", "16oz" => "$27"}

    # raja oolong chai , no tea info
    raja = Tea.new("raja oolong chai")
    raja.url = "https://www.adagio.com/chai/raja_oolong_chai.html"
    
    # vanilla green
    vanillaGreen = Tea.new("vanilla green")
    vanillaGreen.url = "https://www.adagio.com/green/vanilla_green.html"
    vanillaGreen.description = "According to the International Ice Cream Association, Vanilla is by far the most popular flavor, getting a full 23% of all ice cream consumption. Inspired by this love, Adagio has created Vanilla Green Tea, combining the rich, warm dark sugar aroma of vanilla with delicate Chinese green tea. Soothing, sweet and very 'beany' vanilla fragrance (like warm sugar cookies made with fresh vanilla beans)."
    vanillaGreen.ingredients = "Green Tea & Natural Vanilla Flavor"
    vanillaGreen.pricing = {"sample" => "$3", "3oz" => "$9", "16oz" => "$29"} 
    
    # raspberry patch
    raspy = Tea.new("raspberry patch") 
    raspy.url = "https://www.adagio.com/herbal/raspberry_patch.html"
    
end 


