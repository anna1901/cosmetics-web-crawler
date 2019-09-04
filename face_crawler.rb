require './lib/cosmetics_crawler'

BASE_CRAWLING_URL = "https://sylveco.pl/sklep/?filter_przeznaczenie=twarz"

I18n.available_locales = [:en]

class Product < Struct.new(:name, :rating, :price, :ingredients); end

main_page_crawler = Crawler.new(BASE_CRAWLING_URL)

product_list = main_page_crawler.get_list("ul.shop-products li")

products = BuildElements.new(product_list).iterate

formatter = Formatter.new(products)
formatter.save("face_cosmetics_sylveco.csv")
