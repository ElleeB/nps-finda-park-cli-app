class FindaPark::Park

  attr_accessor :name, :state, :city, :contact, :blurb, :url, :catch_phrase, :season_info, :hours

  @@all_parks

  def initialize
    # assign attributes
    # save
  end

  def self.create_from_collection
    # use collection of parks to instantiate instances of parks
    # assign designation, name, city, blurb, url
  end

  def add_attributes
    # add catch phrase, contact, info url
  end

  def add_season_info_hours
  end

end
