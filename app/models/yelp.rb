class Yelp < ActiveRecord::Base
  
  include HTTParty
  base_uri 'api.yelp.com'

  def initialize(service, page)
    @options = { query: { site: service, page: page } }
  end

  def search
    self.class.get("/v3/businesses/search", @options)
  end

end

options = {

}
mexican,chinese,whatever

yelp = Yelp.new("yelp", location)
puts yelp.search

categories = session[:categories]
location = session[:location]

response = "https://api.yelp.com/v3/businesses/
search?categories=#{categories}&location=#{location}&sort=2&limit=10&term=restaurants&radius_filter=2"

