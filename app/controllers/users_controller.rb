# GET USERS - DISPLAY ALL USERS(?)
get '/users' do 
	erb :'users/index'
end

# GET NEW - SINGUP PAGE
get '/users/new' do 
	erb :'/users/new'
end

# POST USERS - CREATE A USER
post '/users' do 
	user = User.new(params[:user])
	user.password = params[:password]

	if params[:password] == params[:password_confirmation]
		if user.save
			redirect '/'
		else
			@errors = user.errors.full_messages
			erb '/users/new'
		end
	else
		@errors = ['Match your passwords do not. Try again. Mmmmmmm.']
		erb :'/users/new'
	end
end

get '/users/:id' do 
	if logged_in?
		erb :'/users/show'
	else
		erb :'/sessions/new'
	end
end