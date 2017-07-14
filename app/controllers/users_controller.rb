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
	@user = User.new(params[:user])
	@user.password = params[:password]

	if params[:password] == params[:password_confirmation]
		if @user.save
			session[:id] = @user.id
    		redirect "/users/#{@user.id}"
		else
			@errors = user.errors.full_messages
			erb '/users/new'
		end
	else
		@errors = ['Match your passwords do not. Try again. Mmmmmmm.']
		erb :'/users/new'
	end
end

# SHOW USER
get '/users/:id' do 
	@user = User.find(params[:id])

	if @user.id == current_user.id
		erb :'/users/show'
	else
		erb :'/sessions/new'
	end
end

# EDIT USER
get '/users/:id/edit' do
  @user = User.find(params[:id])
  redirect "/users/#{@user.id}" unless @user.id == current_user.id
  erb :'/users/edit'
end

# UPDATE USER
put '/users/:id' do
  current_user.update_attributes(params[:user])
  if @user.valid?
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :"users/edit"
  end
end

# DELETE USER
delete '/users/:id' do
  current_user.destroy!
  @errors = ["User has been deleted."]
  erb :index
end