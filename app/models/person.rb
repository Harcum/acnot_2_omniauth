class Person < ApplicationRecord
  
    has_many :people_roles
    has_many :email_people
    has_many :roles, :through => :people_roles
    
    has_many :selectable_reasons, :through => :roles
    has_many :selectable_actions, :through => :roles
    
    has_many :role_reasons, :through => :roles
    has_many :reasons, :through => :role_reasons

    has_many :role_actions, :through => :roles
    has_many :action_types, :through => :role_actions
    
    has_many :notification_viewers
    has_many :notifications, :through => :notification_viewers
    
    belongs_to :user
    
      def full_name
    "#{first_name} #{last_name}"
    end
end
