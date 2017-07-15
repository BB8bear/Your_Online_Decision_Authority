# require_relative '../helpers/yelp'

get '/' do 
	p ENV["YELP_API_KEY"]
	erb :index
end

get '/new' do 
	erb :new
end

post '/' do 
	if (@categories = params[:categories])
		p "Categories -------------------------------------"
		p @categories

		session[:categories] = [] unless session[:categories]

		session[:categories] << @categories
		p "Session -------------------------------------"
		p session[:categories]
	end

	session[:location] = params[:location] if params[:location] && params[:location].length > 0

	if (@location = session[:location])
		p "Location -------------------------------------"
		p session[:location]
		erb :index
	else
		@errors = ['Enter a location, you must. Herh herh herh.']
		redirect '/'
	end
end

post '/submit' do 
	@location = session[:location]
	@categories = format_categories(session[:categories])

	p "Formatted Categories -------------------------------------"
	p @categories 


	response = HTTParty.get("https://api.yelp.com/v3/businesses/search?categories=#{@categories}&location=#{@location}&sort=2&limit=1&term=restaurants&radius_filter=2", headers: {"Authorization" => ENV['YELP_API_KEY']})

	puts response.body, response.code, response.message, response.headers.inspect

	# yelp = YelpAPI.new(@location, @categories)
	# p "Yelp request return -------------------------------------"
	# p yelp
	# suggestion = yelp.search
	# p suggestion

	# return suggestion
end