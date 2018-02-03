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
    add_attributes_to_parks # raises this error: `open_http': 404 Not Found (OpenURI::HTTPError)
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
  end

  def make_parks
    puts "Please enter the number of the state you'd like to explore."
    puts ""
    input = gets.chomp
    state_url = FindaPark::State.all[input.to_i - 1].url
    parks_array = FindaPark::Scraper.state_parks_scraper(state_url)
    FindaPark::Park.create_from_collection(parks_array)
    # input
  end

  def add_attributes_to_parks # raises this error: `open_http': 404 Not Found (OpenURI::HTTPError)
    FindaPark::Park.all.each do |p|
      park_url = "#{p.park_url}"
      # attributes_hash = FindaPark::Scraper.attributes_scraper(park_url)
      # p.add_park_attributes(attributes_hash)
    end
  end

  def list_parks
    parks = FindaPark::Park.all
    parks.each.with_index(1) do |p, i|
      puts "***"
      puts ""
      puts "#{i}"
      puts "#{p.name}" #if statements in case one of these is missing?
      puts "#{p.location}"
      puts "#{p.designation}"
      puts "#{p.blurb}"
    end
  end

  def display_park_details
    puts ""
    puts "Please enter the number of the park you'd like to explore."
    puts ""
    input = gets.chomp
    park = FindaPark::Park.all[input.to_i - 1]
    puts "#{park.name}"
    puts "#{park.location}"
    puts "#{park.catch_phrase}" ## NOT WORKING
    puts "#{park.blurb}" # + Read More
    puts "#{park.season_info}" ## NOT WORKING
    puts "#{park.hours}" ## NOT WORKING
  end



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


    # def add_attributes_to_students
    #   Student.all.each do |student|
    #     attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
    #     student.add_student_attributes(attributes)
    #   end
    # end
