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

  # # use collection of state's parks to instantiate parks # add to @parks
  def add_parks
    FindaPark::Park.all.each do |park|
      if park.state == self.name
        @parks << park
      else
        nil
      end
    end
  end

  def self.all
    @@all_states
  end

  def save
    @@all_states << self
  end
end
