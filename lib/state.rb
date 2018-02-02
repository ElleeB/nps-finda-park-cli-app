class FindaPark::State

  attr_accessor :name, :park, :url

  @@all_states = []

  @parks = []

  def initialize
    # define attributes
    # add to @@all_states - .save
  end

  def self.create_from_collection
    # use collection of states from scraper to instantiate instances of states
    # assign name & url
  end

  def add_parks
    # use collection of state's parks to instantiate instances of parks
    # add to @parks
  end

  def save
    @@all_states << self
  end


end
