class FindaPark::Scraper

  @states_array = []

  def self.index_scraper(index_url)
    doc = Nokogiri::HTML(open(index_url))
    states = doc.css("select#state").search("option")
    states.each{ |s| @states_array << s.text}
    @states_array
  end

end
