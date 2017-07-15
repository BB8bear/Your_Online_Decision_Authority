class YelpAPI
  
  include HTTParty
  base_uri 'api.yelp.com/v3/businesses/search'

  def initialize(location, categories)
    @options = { query: { categories: categories, location: location, sort: "2", limit: "1", term: "restaurants", radiul_filter: "2" } }
  end

  def search
  	self.class.get(@options)
  end
end

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


