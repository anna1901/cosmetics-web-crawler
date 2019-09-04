class Crawler

  def initialize (page)
    @page = page
  end
  
  def crawled_page
    Mechanize.new.get (@page)
  end

  def get_list (css_element)
    crawled_page.root.css(css_element)
  end

end
