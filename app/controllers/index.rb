get '/' do 
	p ENV["YELP_API_KEY"]
	erb :index
end

get '/new' do 
	erb :new
end

post '/' do 
	if (@categories = params[:categories])
		p "Categories"
		p @categories

		session[:categories] = [] unless session[:categories]

		session[:categories] << @categories
		p "Session"
		p session[:categories]
	end

	session[:location] = params[:location] if params[:location] && params[:location].length > 0

	if (@location = session[:location])
		p "Location"
		p session[:location]
		erb :index
	else
		@errors = ['Enter a location, you must. Herh herh herh.']
		redirect '/'
	end
end

post '/' do 

end