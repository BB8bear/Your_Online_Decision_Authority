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

		search_result = response["businesses"][0]

		p @recommendation = search_result["name"]
  		p @url = search_result["url"]
		p @review_count = search_result["review_count"]
		p @rating = search_result["rating"]
		p @stars = star_rating(@rating)

		erb :index
	else
		@errors = ['Enter a location, you must. Herh herh herh.']
		redirect '/'
	end
end