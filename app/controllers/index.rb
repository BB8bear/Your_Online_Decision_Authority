# require_relative '../helpers/yelp'

get '/' do 
	p ENV["YELP_API_KEY"]
	erb :index
end

get '/new' do 
	erb :new
end

post '/' do 
	@location = params[:search][:location] if params[:search][:location].length > 0

	@categories = params[:search][:categories] if params[:search][:categories].length > 0

	if @location.length > 0 && @categories.length > 0
		location = @location
		categories = format_categories(@categories)

		response = search(location, categories)

		search_result = response["businesses"]

		@recommendation = search_result[0]["name"]

		erb :index
	else
		@errors = ['Enter a location, you must. Herh herh herh.']
		redirect '/'
	end
end


	


	# response = HTTParty.get("https://api.yelp.com/v3/businesses/search?categories=#{@categories}&location=#{@location}&sort=2&limit=1&term=restaurants&radius_filter=2", headers: {"Authorization" => ENV['YELP_API_KEY']})

	# p response.body
	# p response.code
	# p response.message 
	# p response.headers.inspect


	# p Yelp.client.search('San Francisco', { term: 'food' })

	# yelp = YelpAPI.new(@location, @categories)
	# p "Yelp request return -------------------------------------"
	# p yelp
	# suggestion = yelp.search
	# p suggestion

	# return suggestion



	# p JSON.pretty_generate(response["businesses"])
