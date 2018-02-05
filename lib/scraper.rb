class FindaPark::Scraper

  # returns an array of all state
  def self.index_scraper(index_url)
    @states_array = []
    doc = Nokogiri::HTML(open(index_url))
    states = doc.css("select#state").search("option")
    states.each do |s|
      state_hash = {:name => nil, :url => nil}
      state_hash[:name] = s.text
      state_hash[:url] = "https://www.nps.gov/state/#{s.attribute("value")}/index.htm"
      @states_array << state_hash
    end
    @states_array.shift
    @states_array
  end

  # returns and array of state's parks
  def self.state_parks_scraper(state_url)
    @parks_array = []
    doc = Nokogiri::HTML(open(state_url))
    parks = doc.css("div.list_left")
    parks.each do |p|
      state_park_hash = {:state => nil, :designation => nil, :name => nil, :location => nil, :blurb => nil, :park_url => nil, :season_info => nil, :hours => nil}
      state_park_hash[:state] = doc.css("h1.page-title").text
      state_park_hash[:designation] = p.css("h2").text
      state_park_hash[:name] = p.css("a").text
      state_park_hash[:location] = p.css("h4").text
      state_park_hash[:blurb] = p.css("p").text
      state_park_hash[:park_url] = "https://www.nps.gov#{p.css("a").attribute("href")}index.htm"
      @parks_array << state_park_hash
    end
    @parks_array
  end

  # This doesn't happen until after the states and parks are made
  def self.additional_info_scraper(park_url)
    FindaPark::Park.all.each do |park_hash|
      doc = Nokogiri::HTML(open("#{park_hash[:park_url]}"))
      park_hash[:catch_phrase] = doc.css("h1.page-title").text
      park_hash[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
    end
  end
  # def self.additional_info_scraper(park_url)
  #   doc = Nokogiri::HTML(open(park_url))
  #   FindaPark::Park.all do |park_hash|
  #     park_hash[:catch_phrase] = doc.css("h1.page-title").text
  #     park_hash[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
  #   end
  # end

  def self.hours_seasons_scraper(parks_array)
    # (info_url)
  end

end





    # # add additional attributes from park's page
    # @parks_array.each do |p|
    #   park_url = p[:park_url]
    #   doc = Nokogiri::HTML(open(park_url))
    #   p[:catch_phrase] = doc.css("h1.page-title").text
    #   # p[:contact] = doc.css("div.vcard")
    #   p[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
    # end
    #
    # # add additional attributes from park's info page
    # @parks_array.each do |p|
    #   info_url = p[:info_url]
    #   doc = Nokogiri:: HTML(open(info_url))
    #   p[:season_info] = doc.css("div.operating-hours p").text
    #   p[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
    # end


# park_url = p[:park_url]
# doc = Nokogiri::HTML(open(park_url))
# p[:catch_phrase] = doc.css("h1.page-title").text
# # p[:contact] = doc.css("div.vcard")
# p[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
