class FindaPark::State
  attr_accessor :name, :url, :parks

  @@all_states = []

  def initialize(state_hash)
    @name = state_hash[:name]
    @url = state_hash[:url]
    @parks = []
    self.save
  end

  # use collection of states from scraper to instantiate states
  def self.create_from_collection(states_array)
    states_array.each do |state_hash|
      FindaPark::State.new(state_hash)
    end
  end

  # def parks
  #   @parks
  # end

  def self.all
    @@all_states
  end

  def save
    @@all_states << self
  end
end
