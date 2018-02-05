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
    # @contact = contact # detailed address, city, state, zip, phone ***************** I don't think these get added until cli?
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

  def self.all
    @@all_parks
  end

  def save
    @@all_parks << self
  end

end
