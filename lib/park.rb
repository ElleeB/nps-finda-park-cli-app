class FindaPark::Park

  attr_accessor :name, :state, :designation, :location, :park_url, :street_address, :phone, :blurb, :info_url, :catch_phrase, :season_info, :hours

  @@all_parks = []

  def initialize(park_hash)
    park_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.save
    self
  end

  # use collection of parks to instantiate parks, give parks a state, give states parks, and assign state, designation, name, location, blurb, url
  def self.create_from_collection(parks_array)
    parks_array.each do |park_hash|
      park = self.new(park_hash)
      FindaPark::State.all.each do |state|
        if park.state == state.name
          park.state = state
          state.parks << park
        else
          nil
        end
      end
    end
  end

  # add catch_phrase, street_address, phone, info_url
  def add_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  # use info_url to add season and hours info
  def add_hours_seasons(info_hash)
    info_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@all_parks
  end

  def save
    @@all_parks << self
  end
end
