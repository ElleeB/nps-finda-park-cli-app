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
    @contact = nil # detailed address, city, state, zip, phone ***************** I don't think these get added until cli?
    @blurb = park_hash[:blurb]
    @info_url = nil
    @catch_phrase = nil
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

  # def add_park_attributes(attributes_hash)
  #   attributes_hash.each do |key, value|
  #     self.send("#{key}=", value)
  #   end
  # end
  #
  # def add_season_info_hours
  #   @@all_parks.each do |p|
  #     info_url = "#{p.info_url}"
  #     info_hash = FindaPark::Scraper.info_scraper(info_url)#`open_http': 404 Not Found (OpenURI::HTTPError)
  #     p.season_info = info_hash[:season_info]
  #     p.hours = info_hash[:hours]
  #   end

    # def add_student_attributes(attributes_hash)
    #   attributes_hash.each do |key, value|
    #     self.send("#{key}=", value)
    #   end
    # end
  # end

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
