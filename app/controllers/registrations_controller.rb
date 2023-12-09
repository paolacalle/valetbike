class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        resource.first_name = params[:user][:first_name]
        resource.last_name = params[:user][:last_name]
        resource.has_bike = false
        resource.save
        sign_in(resource) if resource.persisted?
      end
    end
  
    private
  
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end
  