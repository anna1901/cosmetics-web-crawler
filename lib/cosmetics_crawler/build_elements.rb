class BuildElements
  def initialize (product_list)
    @product_list = product_list
  end

  def iterate
    products = []
    @product_list.each do |product_element|
      name = text_from_css(product_element, "h3")
      rating = text_from_css(product_element, ".star-rating span")
      price = text_from_css(product_element, ".product-price span")[0..-3] #-3 to cut the "zł" ending of the price
      ingredients = get_ingredients(name)

      product = Product.new(name, rating, price, ingredients)
      products << product
    end
    products
  end

  private

  def text_from_css (element, css_tag)
    element.at_css(css_tag).nil? ? "NA" : element.at_css(css_tag).text.strip
  end

  def get_ingredients (name)
    product_link = "https://sylveco.pl/produkt/#{I18n.transliterate(name).downcase.split.join("-")}/"
    product_page = Crawler.new(product_link).crawled_page
    ingredients = text_from_css(product_page, "#tab-inci_tab p")
  end
end
