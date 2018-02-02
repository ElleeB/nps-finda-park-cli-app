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
    state_park_hash = {:designation => nil, :name => nil, :city => nil, :blurb => nil, :url => nil}
  end

    def park_scraper(park_url)
      park_hash = {:catch_phrase => nil, :address => nil, :phone => nil, :info_url => nil}
    end

    def info_scraper(info_url)
      #obtain seasons and hours
    end

end
