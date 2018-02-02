class FindaPark::CLI

  # structure

  def call
    # greet user
    puts ""
    puts "Welcome, Adventurers!"
    puts "---------------------"
    puts "Find your next escape in any one of the 56 states and territories listed below. Enjoy!"
    puts ""
    make_states
    list_states
    make_parks
    list_parks
  end

  def make_states
    index_url = "https://www.nps.gov/findapark/index.htm"
    states_array = FindaPark::Scraper.index_scraper(index_url)
    FindaPark::State.create_from_collection(states_array)
  end

  def list_states
    states = FindaPark::State.all
    states.each.with_index(1) do |s, i|
      puts "* #{s.name} * #{i}"
    end
  end

  def make_parks
    puts "Please enter the number of the state you'd like to explore."
    puts ""
    input = gets.chomp
    state_url = FindaPark::State.all[input.to_i - 1].url
    parks_array = FindaPark::Scraper.state_parks_scraper(state_url)
    FindaPark::Park.create_from_collection(parks_array)
  end

  def list_parks
    parks = FindaPark::Park.all
    parks.each.with_index(1) do |p, i|
      puts ""
      puts "#{i}.  #{p.name}"
      puts ""
    end
  end


  # ask for input (state selection)
  # present list of parks
  # ask for input (park selection)
  # display park blurb and contact info

  # methods

  # call
  # run
  # make_parks
  # add_attributes
  # states_menu
  # parks_menu
  # park_info
  # goodbye

end
