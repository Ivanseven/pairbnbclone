class UsersController < Clearance::UsersController
	def edit
		@user = User.find(current_user.id)
	end
	def update
		@user = User.find(current_user.id)
		@user.update(user_params)
		redirect_to root_path
	end

	private

	def user_from_params
		User.new(user_params)
		first_name = user_params.delete(:first_name)
		last_name = user_params.delete(:last_name)
		email = user_params.delete(:email)
	    password = user_params.delete(:password)

	    Clearance.configuration.user_model.new(user_params).tap do |user|
			user.first_name = first_name
			user.last_name = last_name
			user.email = email
			user.password = password
	    end		
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

end
