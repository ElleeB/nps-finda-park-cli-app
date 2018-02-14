# Specifications for the CLI Assessment

Make sure to check each box in your spec.md (replace the space between the square braces with an x) and explain next to each one how you've met the requirement before you submit your project.

Specs:
- [X] Have a CLI for interfacing with the application
      * My CLI provides the user with clear prompts, information, and simple navigation, allowing for easy interaction with the app.
- [X] Pull data from an external source
      * I used Nokogiri and OpenURI to scrape and pull info from the national park's search index page, from individual state pages, from individual park pages, and from specific info pages. I created a separate scraper method for each page/data and collected data in hashes to be used later in creating objects.
- [X] Implement both list and detail views
      * Within the application, the user is presented with two main lists: the states and the states' parks; the individual parks are then presented in detail.
