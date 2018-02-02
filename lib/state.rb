class FindaPark::State
  attr_accessor :name, :url, :park

  @@all_states = []
  @parks = []

  def initialize(state_hash)
    @name = state_hash[:name]
    @url = state_hash[:url]
    @park = nil
    self.save
  end

  # use collection of states from scraper to instantiate states
  def self.create_from_collection(states_array)
    states_array.each do |state_hash|
      FindaPark::State.new(state_hash)
    end
  end

  # use collection of state's parks to instantiate parks # add to @parks
  def add_parks

  end

  def self.all
    @@all_states
  end

  def save
    @@all_states << self
  end
end
