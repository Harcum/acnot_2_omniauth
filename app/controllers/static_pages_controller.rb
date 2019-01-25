class StaticPagesController < ApplicationController
  
    skip_before_action :authenticate_user!
    
    def home
      redirect_to "/notifications"
    end
    
    def password_reset_sent
    end
end
