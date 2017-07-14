# GET SESSIONS
get '/sessions/new' do 
	erb :'/sessions/new'
end

# POST SESSIONS
post '/sessions' do 
	@user = User.find_by(email: params[:email])

	if @user && @user.authenticate(params[:password])
		session[:id] = @user.id
		redirect '/users/show'
	else
		@errors = ['Incorrect, your login or password is. Try again.']
		erb :'/session/new'
	end
end

# DELETE SESSIONS
delete '/sessions' do 
	session[:id] = nil
	redirect '/'
end


