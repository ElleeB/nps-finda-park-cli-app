class FindaPark::CLI

  # structure

  def call
    # greet user
    puts ""
    puts "Welcome, Adventurers!"
    puts "---------------------"
    puts "Find your next escape in any one of the 56 states and territories listed below. Enjoy!"
    puts ""
    run
  end

  def run
    make_states
    list_states
    make_parks_of_state
    list_parks_of_state
    add_attributes_to_parks
    display_park_details
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
    puts ""
    puts "Please enter the number of the state you'd like to explore."
  end

  def make_parks_of_state
    puts ""
    input = gets.chomp
    state_url = FindaPark::State.all[input.to_i - 1].url
    parks_array = FindaPark::Scraper.state_parks_scraper(state_url)
    FindaPark::Park.create_from_collection(parks_array)
  end

  def list_parks_of_state
    FindaPark::Park.all.each.with_index(1) do |p, i|
      puts "***"
      puts ""
      puts "#{i}"
      puts p.name #if statements in case one of these is missing?
      puts p.location
      puts p.designation
      puts p.blurb
    end
    puts ""
    puts "Please enter the number of the park you'd like to explore."
  end

  def add_attributes_to_parks
    FindaPark::Park.all.each do |p|
      park_url = p.park_url
      attributes_hash = FindaPark::Scraper.park_page_scraper(park_url)
      p.add_attributes(attributes_hash)
    end
  end

  def add_hours_seasons_to_parks # if info_url = nil puts "Sorry, but there is no more information on this park"
    FindaPark::Park.all.each do |p|
      info_url = p.info_url
      info_hash = FindaPark::Scraper.hours_seasons_scraper(info_url)
      p.add_hours_seasons(info_hash)
    end
  end

  def display_park_details # with 404 error handling | !! this method takes the longest to run (makes sense) - can I speed it up?
    input = gets.chomp
    p = FindaPark::Park.all[input.to_i - 1]

    begin
      info_url = p.info_url
      open(info_url)

    rescue OpenURI::HTTPError => e

      if e.message == '404 Not Found'
        puts ""
        puts "Our apologies - there is no further infomation on the following park:"
        puts ""
        puts p.name
        puts ""
        puts "----------------------------------------------------------------------------------------------------------"

        input_options
        # puts "Please enter 'parks' to return to the parks menu, 'states' to return to the states menu, or 'exit' to quit"
        # puts ""
        # input = gets.chomp.downcase
        #
        # if input == "parks"
        #   list_parks_of_state
        #   display_park_details
        # elsif input == "states"
        #   run
        # elsif input == "exit"
        #   goodbye
        # end

      else # now this is broken and won't work for funtioning links
        nil
      end
    else
      puts p.name
      puts p.catch_phrase
      puts p.blurb # + Read More ???  #
      puts ""
      puts p.season_info
      puts p.hours
      puts ""
      puts p.contact
      puts "----------------------------------------------------------------------------------------------------------"

      input_options
      # puts "Please enter 'parks' to return to the parks menu, 'states' to return to the states menu, or 'exit' to quit"
      # puts ""
      # input = gets.chomp.downcase
      #
      # if input == "parks"
      #   list_parks_of_state
      #   display_park_details
      # elsif input == "states"
      #   run
      # elsif input == "exit"
      #   goodbye
      # end
    end
  end

  def input_options
    puts "Please enter 'parks' to return to the parks menu, 'states' to return to the states menu, or 'exit' to quit"
    puts ""
    input = gets.chomp.downcase

    if input == "parks"
      list_parks_of_state
      display_park_details
    elsif input == "states"
      run
    elsif input == "exit"
      goodbye
    end
  end

  def goodbye
    puts "Thanks for visiting. Cheers to your next adventure!"
  end

end
