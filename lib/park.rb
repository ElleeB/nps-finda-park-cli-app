class FindaPark::Park

  attr_accessor :name, :state, :designation, :location, :park_url, :street_address, :phone, :blurb, :info_url, :catch_phrase, :season_info, :hours

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

  # use collection of parks to instantiate instances of parks # assign state, designation, name, location, blurb, url
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

  def valid_attributes
    p.instance_variables.each do |a|

      puts a


    #   if a == nil
    #     puts "nil"
    #   else
    #     puts "not nil!"
    #   end
    end
  end

  # def validate_attributes
  #   instance_variables.find do |v|
  #     if v == nil
  #       puts v
  #     else
  #       puts "NOT NIL"
  #     end
  #   end
  # end

  def self.all
    @@all_parks
  end

  def save
    @@all_parks << self
  end

end
