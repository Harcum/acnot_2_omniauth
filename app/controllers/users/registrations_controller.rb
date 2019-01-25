#class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]


class Users::RegistrationsController < Devise::RegistrationsController


  before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication
  
  def create
    puts 'entering Users::RegistrationsController#create'
    super

    
  end

  private
  def redirect_unless_admin
    unless current_user.try(:admin?)
      flash[:error] = "Only admins can do that"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end

  
  def after_sign_up_path_for(resource)
    users_path(resource)
  end
 
  #def new
  #  super
  #end
 
   def sign_up_params
      #allow = [:email, :your_fields, :password, :password_confirmation]
      params.require(resource_name).permit! # I am a shitty human being. I know.
    end
  
 
end
