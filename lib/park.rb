class FindaPark::Park

  attr_accessor :name, :state, :designation, :location, :park_url, :contact, :blurb, :info_url, :catch_phrase, :season_info, :hours

  @@all_parks = []

  # assign attributes # save
  # def initialize(params)
  #   params.each do |key, value|
  #     instance_variable_set("@#{key}", value)
  #   end
  # end
  # !!! see above !!! #
  def initialize(park_hash)
    @name = park_hash[:name]
    @state = park_hash[:state]
    @designation = park_hash[:designation]
    @location = park_hash[:location] # changed from ":city"
    @park_url = park_hash[:park_url]
    @contact = park_hash[:contact] # detailed address, city, state, zip, phone ***************** I don't think these get added until cli?
    @blurb = park_hash[:blurb]
    @info_url = park_hash[:info_url] # *******************
    @catch_phrase = park_hash[:catch_phrase] # **********************
    @season_info = nil
    @hours = nil
    self.save
  end

  # use collection of parks to instantiate instances of parks # assign designation, name, location, blurb, url
  def self.create_from_collection(parks_array)
    parks_array.each do |park_hash|
      FindaPark::Park.new(park_hash)
    end
  end

  def add_park_attributes
    park_hash = FindaPark::Scraper.park_scraper(self.park_url)
    @all.each do |park|
      park.catch_phrase = park_hash[:catch_phrase]
      park.contact = park_hash[:contact]
      park.info_url = park_hash[:info_url]
    end
  end

  def add_season_info_hours
    info_hash = FindaPark::Scraper.info_scraper(self.info_url)
    @@all.each do |park|
      park.season_info = info_hash[:season_info]
      park.hours = info_hash[:hours]
    end
  end



  def contact_parser # !!! need to do this !!! #
    self.contact
  end

  def self.all
    @@all_parks
  end

  def save
    @@all_parks << self
  end

end
