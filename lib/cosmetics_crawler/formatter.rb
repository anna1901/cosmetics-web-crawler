class Formatter
  def initialize (products)
    @products = products
  end
  def save (file_name)
    CSV.open(file_name, "w", col_sep: ";") do |csv|
      csv << ["Name", "Rating", "Price", "Ingredients"]
      @products.each do |product|
        csv << [product.name, product.rating, product.price, product.ingredients]
      end
    end
  end

end
