require 'mechanize'
require 'csv'
require "i18n"
require 'awesome_print'
require './lib/cosmetics_crawler/mechanize_client'
require './lib/cosmetics_crawler/product'

I18n.available_locales = [:en]



#a table that will store all the products on that page
products = []

agent = MechanizeClient.new

main_page = agent.get "https://sylveco.pl/sklep/?filter_przeznaczenie=twarz"

#create a table with all the products on that page
product_list = main_page.root.css("ul.shop-products li")

product_list.each do |product_element|
  name = product_element.at_css("h3").text.strip
  rating = product_element.at_css(".star-rating span").nil? ? "no rating" : product_element.at_css(".star-rating span").text.strip
  price = product_element.at_css(".product-price span").text.strip[0..-3]

  product_link = "https://sylveco.pl/produkt/#{I18n.transliterate(name).downcase.split.join("-")}/"
  product_page = agent.get product_link
  ingredients = product_page.at_css("#tab-inci_tab p").text.strip

  product = Product.new(name, rating, price, ingredients)
  products << product
end

ap products
=begin
CSV.open("face_cosmetics_sylveco.csv", "w", col_sep: ";") do |csv|
  csv << ["Name", "Rating", "Price", "Ingredients"]
  products.each do |product|
    csv << [product.name, product.rating, product.price, product.ingredients]
  end
end
=end
