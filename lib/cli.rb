class FindaPark::CLI

  def call
    puts
    puts "----------------------------------------------------------------------------------------------------------"
    puts
    puts "FIND YOUR PERFECT NATIONAL PARK".bold.colorize(:green)
    puts
    puts "Welcome, Adventurers!".bold
    puts "---------------------".colorize(:green)
    puts "Find your next escape in any one of the 56 states and territories listed below. Enjoy!".bold
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
    add_attributes_to_parks # how can I improve the processing from here down? AND split this into 2?
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
    puts
    puts "Please enter the number of the state you'd like to explore.".italic
  end

  def make_parks_of_state
    puts
    input = gets.chomp
    state_url = FindaPark::State.all[input.to_i - 1].url
    parks_array = FindaPark::Scraper.state_parks_scraper(state_url)
    FindaPark::Park.create_from_collection(parks_array)
  end

  def list_parks_of_state
    FindaPark::Park.all.each.with_index(1) do |p, i|
      puts "***".bold
      puts
      puts "#{i}"
      puts p.name.bold
      puts p.location
      puts p.designation == "" ? "---" : "Designation: #{p.designation}"
      puts p.blurb == "" ? "nil" : wrap("#{p.blurb}".slice(0, 150) + "...", 79)
      puts "For more info, enter park number.".italic # how to put only the first  so many words + ... ??
    end
    puts
    puts "Please enter the number of the park you'd like to explore.".italic
    puts
  end

  def add_attributes_to_parks
    FindaPark::Park.all.each do |p|
      park_url = p.park_url
      attributes_hash = FindaPark::Scraper.park_page_scraper(park_url)
      p.add_attributes(attributes_hash)
    end
  end

  def display_park_details # need two methods here: check_link_for_error & display_park_details
    input = gets.chomp
    p = FindaPark::Park.all[input.to_i - 1]

    begin
      info_url = p.info_url
      open(info_url)

    rescue OpenURI::HTTPError => e

      if e.message == '404 Not Found'.bold
        puts
        puts "Our apologies - there is no further infomation on the following park:".bold
        puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
        puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
        input_options
      else
        nil
      end
################################
    else
      puts
      puts "***".bold
      puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
      puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
      info_hash = FindaPark::Scraper.hours_seasons_scraper(info_url) # try to reconfigure into it's own method
      p.add_hours_seasons(info_hash)
      puts p.name == "" ? (puts "NA") : p.name.bold
      puts p.catch_phrase == "" ? "nil" : p.catch_phrase.italic
      puts p.blurb == "" ? (puts "NA") : wrap("#{p.blurb}")
      puts
      puts "Season Information:".bold
      puts p.season_info == "" || nil ? (puts "NA") : wrap("#{p.season_info}") # "nil" necessary when the info_url doesn't exist for a park
      puts
      puts "Hours:".bold
      puts p.hours  == "" || nil ? (puts "NA"): p.hours # "nil" necessary when the info_url doesn't exist for a park
      puts
      puts "Mailing Address:".bold
      puts p.street_address == "" ? (puts "NA") : p.street_address
      puts p.phone == "" ? (puts "NA") : p.phone
      puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
      puts "----------------------------------------------------------------------------------------------------------".colorize(:green)
      input_options
    end
  end

  def input_options
    puts "Please enter 'parks' to return to the parks menu, 'states' to return to the states menu, or 'exit' to quit".italic
    puts
    input = gets.chomp.downcase

    if input == "parks"
      list_parks_of_state
      display_park_details
    elsif input == "states" # how to stop this from indexing from previous run ex. west Virginia * 110
      run
    elsif input == "exit"
      goodbye
    end
  end

  def wrap(s, width=106)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

  def goodbye
    puts "Thanks for visiting. Cheers to your next adventure!".bold
  end
end


# need to create a valid_input check so that it doesn't just kick user out - also, need an escape from the
# "please enter the number of the park you'd like to see"...
