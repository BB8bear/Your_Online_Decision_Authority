require "json"
require "http"
require "optparse"

module YelpHelpers
	def format_categories(categories)
  	category_list_storage = ""

  	categories.each do |category|
  		category_list_storage << "#{category},"
  	end
  	category_list = category_list_storage.chop
  	return category_list
  end
end

helpers YelpHelpers

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/" # trailing / because we append the business id to the path
TOKEN_PATH = "/oauth2/token"

# Returns your access token
def bearer_token
  # Put the url together
  url = "#{API_HOST}#{TOKEN_PATH}"

  # Build our params hash
  params = {
    client_id: ENV['CLIENT_ID'],
    client_secret: ENV['CLIENT_SECRET'],
    grant_type: ENV['GRANT_TYPE']
  }

  response = HTTP.post(url, params: params)
  parsed = response.parse

  "#{parsed['token_type']} #{parsed['access_token']}"
end

# Returns a parsed json object of the request
def search(location, categories)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: "restaurants",
    location: location,
    categories: categories,
    limit: "1",
    radius_filter: "2",
    sort: "2"
  }

  response = HTTP.auth(bearer_token).get(url, params: params)
  response.parse
end

# Returns a parsed json object of the request
def business(business_id)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

  response = HTTP.auth(bearer_token).get(url)
  response.parse
end