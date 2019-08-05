class Product
  attr_accessor :name, :rating, :price, :ingredients

  def initialize (name, rating, price, ingredients)
    @name = name
    @rating = rating
    @price = price
    @ingredients = ingredients
  end
end
