module UsersControllerHelpers

	def login
	  @user = User.find_by_email(params[:email])
	  if @user.password == params[:password]
	    give_token
	  else
	    redirect_to home_url
	  end
	end

	def current_user
		if session[:id]
			@current_user ||= User.find(session[:id]) 
		end
	end

	def logged_in?
		!!current_user
	end

	# def create
	#   @user = User.new(params[:user])
	#   @user.password = params[:password]
	#   @user.save!
	# end

end

helpers UsersControllerHelpers