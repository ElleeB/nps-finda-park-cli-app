class FindaPark::Park

  attr_accessor :name, :state, :designation, :location, :park_url, :contact, :blurb, :info_url, :catch_phrase, :season_info, :hours

  @@all_parks = []

  # !!! see below for abstraction !!! #
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
      self.new(park_hash)
    end
  end

  def add_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def add_hours_seasons(info_hash)
    info_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  # def puts_contact_info
  #   doc = self.contact
  #   mailing = doc.css("h4.org span.street-address")
  #   # city = doc.css("")
  #   # zip = doc.css("")
  #   phone = doc.css("")
  #   puts mailing
  #   # puts "#{city}, #{state} #{zip}"
  # end

  def self.all
    @@all_parks
  end

  def save
    @@all_parks << self
  end

end
