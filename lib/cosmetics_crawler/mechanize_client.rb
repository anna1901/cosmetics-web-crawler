class MechanizeClient
  def initialize
    @agent = Mechanize.new
  end

  def get(web_page)
    @agent.get web_page
  end
end
