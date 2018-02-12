# require 'net/http'
#
# source = Net::HTTP.get('stackoverflow.com', '/index.html')


class FindaPark::CLI

  def call
    puts
    puts "-------------------------------"
    puts
    puts "FIND YOUR PERFECT NATIONAL PARK".bold.colorize(:green)
    puts
    puts "Welcome, Adventurers!".bold
    puts "-------------------------------".colorize(:green)
    puts "Find your next escape in any one of the 56 states and territories listed below.".bold
    puts "Enjoy!".bold
    puts
    puts "Please enter the number of the state you'd like to explore.".italic
    puts
    run
  end

  def run
    make_states
    list_states
    make_parks_of_state
    list_parks_of_state
    add_attributes_to_parks
    check_url_and_display_details
  end

  def make_states
    if FindaPark::State.all == []
      index_url = "https://www.nps.gov/findapark/index.htm"
      states_array = FindaPark::Scraper.index_scraper(index_url)
      FindaPark::State.create_from_collection(states_array)
    else
      nil
    end
  end

  # State menu + asks for input
  def list_states
    states = FindaPark::State.all
    states.each.with_index(1) do |s, i|
      puts "* #{s.name} * #{i}"
    end
    puts
    puts "-------------------------------".colorize(:green)
    puts "Please enter the number of the state you'd like to explore.".italic
  end

  # Creates parks based on the previous input
  def make_parks_of_state
    input = gets.chomp
    state_url = FindaPark::State.all[input.to_i - 1].url
    parks_array = FindaPark::Scraper.state_parks_scraper(state_url)
    FindaPark::Park.create_from_collection(parks_array)
  end

  # Lists all parks of the chosen state + asks for input
  def list_parks_of_state
    FindaPark::Park.all.each.with_index(1) do |p, i|
      puts "***".bold
      puts
      puts "#{i}"
      puts p.name.bold
      puts p.location
      puts p.designation == "" ? "---" : "Designation: #{p.designation}"
      puts p.blurb == "" ? "nil" : wrap("#{p.blurb}".slice(0, 150) + "...")
      puts "For more information, enter park number.".italic
    end
    puts
    puts "-------------------------------".colorize(:green)
    puts "Please enter the number of the park you'd like to explore.".italic
    puts
  end

  # Iterates through all parks of chosen state and adds additional attributes
  def add_attributes_to_parks
    FindaPark::Park.all.each do |p|
      park_url = p.park_url
      attributes_hash = FindaPark::Scraper.park_page_scraper(park_url)
      p.add_attributes(attributes_hash)
    end
  end

  # Iterates through all parks of chosen state and adds hours and season info
  def add_hours_seasons_to_park
    FindaPark::Park.all.each do |p|
      info_url = p.info_url
      info_hash = FindaPark::Scraper.hours_seasons_scraper(info_url)
      p.add_hours_seasons(info_hash)
    end
  end

  # Checks if chosen park's 'info_url' is OK (if not, asks for input), if OK, display_park_details, then asks for input through display_park_details
  def check_url_and_display_details
    input = gets.chomp
    park = FindaPark::Park.all[input.to_i - 1]
    begin
      info_url = park.info_url
      open(info_url)
    rescue OpenURI::HTTPError => e

      if e.message == '404 Not Found'
        puts
        puts "Our apologies - there is no further information on the following park:".bold
        puts park.name
        puts
        puts "-------------------------------".colorize(:green)
        input_options(park) # runs if there's been an error
      else
        nil
      end

    else
      display_park_details(park) # runs if there is no url error (meaning info_url is OK)
    end
  end

  # Displays isolated info on the chosen state park
  def display_park_details(park)
    add_hours_seasons_to_park
    p = park
    park_url = p.park_url
    puts
    puts "***".bold
    puts "-------------------------------".colorize(:green)
    puts "-------------------------------".colorize(:green)
    puts p.name == "" ? (puts "NA") : p.name.bold
    puts p.catch_phrase == "" ? "nil" : p.catch_phrase.italic
    puts p.blurb == "" ? (puts "NA") : wrap("#{p.blurb}")
    puts
    puts "Season Information:".bold
    puts p.season_info == "" || nil ? (puts "NA") : wrap("#{p.season_info}") # info_url may not exist for a park
    puts
    puts "Hours:".bold
    puts p.hours  == "" || nil ? (puts "NA"): p.hours # info_url may not exist for a park
    puts
    puts "Mailing Address:".bold
    puts p.street_address == "" ? (puts "NA") : p.street_address
    puts p.phone == "" ? (puts "NA") : p.phone
    puts "-------------------------------".colorize(:green)
    puts "-------------------------------".colorize(:green)
    puts
    puts "Enter 'parks' for the parks menu, 'states' for the states menu, or 'exit' to quit".italic
    puts
    input_options(p)
  end

  def input_options(park)
    input = gets.chomp.downcase
    if input == "parks"
      list_parks_of_state
      check_url_and_display_details
    elsif input == "states"
      run
    elsif input == "exit"
      goodbye
    end
  end

  def wrap(s, width=79)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

  def goodbye
    puts
    puts "Thanks for visiting. Cheers to your next adventure!".bold.colorize(:green)
    puts
  end
end
