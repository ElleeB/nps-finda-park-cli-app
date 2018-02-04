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
      state_park_hash = {:state => nil, :designation => nil, :name => nil, :city => nil, :blurb => nil, :park_url => nil, :catch_phrase => nil, :contact => nil, :info_url => nil, :season_info => nil, :hours => nil}
      state_park_hash[:state] = doc.css("h1.page-title").text
      state_park_hash[:designation] = p.css("h2").text
      state_park_hash[:name] = p.css("a").text
      state_park_hash[:location] = p.css("h4").text
      state_park_hash[:blurb] = p.css("p").text
      state_park_hash[:park_url] = "https://www.nps.gov#{p.css("a").attribute("href")}index.htm"
      @parks_array << state_park_hash
    end

    # add additional attributes from park's page
    @parks_array.each do |p|
      park_url = p[:park_url]
      doc = Nokogiri::HTML(open(park_url))
      p[:catch_phrase] = doc.css("h1.page-title").text
      # p[:location] = doc.css("div.vcard")
      p[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
    end

    # add additional attributes from park's info page
    @parks_array.each do |p|
      info_url = p[:info_url]
      doc = Nokogiri:: HTML(open(info_url))
      p[:season_info] = doc.css("div.operating-hours p").text
      p[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
    end
    puts @parks_array
  end

  # itterates through the parks_array and assigns remaining attributes to the state_park_hash
  # def self.attributes_scraper(parks_array)
  #
  #   parks_array = parks_array
  #   parks_array.each do |p|
  #     park_url = p[:park_url]
  #     doc = Nokogiri::HTML(open(park_url))
  #     p[:catch_phrase] = doc.css("h1.page-title").text
  #     p[:location] = doc.css("div.vcard")
  #     p[:info_url] = "https://www.nps.gov#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
  #
  #     # info_url = p[:info_url]
  #     # doc = Nokogiri:: HTML(open(info_url))
  #     # p[:season_info] = doc.css("div.operating-hours p").text
  #     # p[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
  #   end
  #   puts parks_array # does not indclude added attributes
  # end
end











# @attributes_hash = {:catch_phrase => nil, :contact => nil, :info_url => nil, :season_info => nil, :hours => nil}
# doc = Nokogiri::HTML(open(park_url))
# attributes_hash[:catch_phrase] = doc.css("h1.page-title").text
# attributes_hash[:contact] = doc.css("div.vcard") # will need to scrape for specifics in Park class | street: span.street-address | city: span attribute = "addressLocality" | state: span.region | zip: span.postal-code | phone: span.tel
# attributes_hash[:info_url] = "https://www.nps.gov/state#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
#
# info_url = attributes_hash[:info_url]
# doc_2 = Nokogiri::HTML(open(info_url))
# attributes_hash[:season_info] = doc.css("div.operating-hours p").text
# attributes_hash[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
# end

# # returns a hash of park's catch phrase, contact info, and url
# def self.park_scraper(park_url)
#   @park_hash = {:catch_phrase => nil, :contact => nil, :info_url => nil}
#   doc = Nokogiri::HTML(open(park_url))
#   park_hash[:catch_phrase] = doc.css("h1.page-title").text
#   park_hash[:contact] = doc.css("div.vcard") # will need to scrape for specifics in Park class | street: span.street-address | city: span attribute = "addressLocality" | state: span.region | zip: span.postal-code | phone: span.tel
#   park_hash[:info_url] = "https://www.nps.gov/state#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
#   park_hash
# end
#
# # returns a hash of park's seasonal info and hours
# def self.info_scraper(info_url)
#   doc = Nokogiri::HTML(open(info_url))
#   @info_hash = {:season_info => nil, :hours => nil}
#   info_hash[:season_info] = doc.css("div.operating-hours p").text
#   info_hash[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
#   info_hash
# end
#
# def additional_attributes
#   attributes_hash =
