class FindaPark::CLI

  # structure

  def call
    # greet user
    puts ""
    puts "Welcome, Adventurers!"
    puts ""

    make_states
    list_states
  end

  def make_states
    index_url = "https://www.nps.gov/findapark/index.htm"
    states_array = FindaPark::Scraper.index_scraper(index_url)
    FindaPark::State.create_from_collection(states_array)
  end

  def list_states
    states = FindaPark::State.all
    states.each.with_index(1) do |s, i|
      puts "#{i}* #{s.name}"
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
