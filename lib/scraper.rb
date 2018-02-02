class FindaPark::Scraper

  def self.index_scraper(index_url)
    @states_array = []
    doc = Nokogiri::HTML(open(index_url))
    states = doc.css("select#state").search("option")
    # => <option value="or">Oregon</option>
    states.each do |s|
      state_hash = {:name => nil, :url => nil}
      state_hash[:name] = s.text
      state_hash[:url] = "https://www.nps.gov/state/#{s.attribute("value")}/index.htm"
      @states_array << state_hash
    end
    @states_array.shift
    @states_array
  end

  def self.state_parks_scraper(state_url)
    @parks_array = []
    doc = Nokogiri::HTML(open(state_url))
    parks = doc.css("div.list_left")
    parks.each do |p|
      state_park_hash = {:designation => nil, :name => nil, :city => nil, :blurb => nil, :url => nil}
      state_park_hash[:designation] = p.css("h2").text
      state_park_hash[:name] = p.css("a").text
      state_park_hash[:city] = p.css("h4").text
      state_park_hash[:blurb] = p.css("p").text
      state_park_hash[:url] = "https://www.nps.gov/state#{p.css("a").attribute("href")}index.htm"
      @parks_array << state_park_hash
    end
    puts @parks_array
  end

    def self.park_scraper(park_url)
      park_hash = {:catch_phrase => nil, :contact => nil, :info_url => nil}
      doc = Nokogiri::HTML(open(park_url))
      park_hash[:catch_phrase] = doc.css("h1.page-title").text
      park_hash[:contact] = doc.css("div.vcard") # will need to scrape for specifics in Park class | street: span.street-address | city: span attribute = "addressLocality" | state: span.region | zip: span.postal-code | phone: span.tel
      park_hash[:info_url] = "https://www.nps.gov/state#{doc.css("div.Utility-nav li a")[0].attribute("href").content}"
      park_hash
    end

    def self.info_scraper(info_url) #https://www.nps.gov/tapr/planyourvisit/basicinfo.htm
      #obtain seasons and hours
      doc = Nokogiri::HTML(open(info_url))
      info_hash = {:season_info => nil, :hours => nil}
      info_hash[:season_info] = doc.css("div.operating-hours p").text
      info_hash[:hours] = doc.css("div.col-sm-12.HoursSection.clearfix ul").text
      info_hash
    end

end
