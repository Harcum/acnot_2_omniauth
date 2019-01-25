class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  before_filter :get_user_stuff
  
    # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(users)
    "/users/sign_in"
  end
  

    def after_sign_in_path_for(users)
     puts('landing: ' + @landing.to_s)  
     if @landing == 1
        "/notifications/new"
     else
      "/notifications"
     end
   end
  
  def get_user_stuff
    if current_user
      if Person.where(email: current_user.email).take
        @current_user_id = Person.where(email: current_user.email).take.id
        @is_admin = Person.where(email: current_user.email).take.roles.where(code: "Admin").count == 1
        @landing = current_user.landing_id
      end
    end
  end
  
  
  
  
end
