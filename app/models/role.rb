class Role < ApplicationRecord

  has_many :role_selectable_reasons
  has_many :selectable_reasons, :through => :role_selectable_reasons ,  :source => :reason
    
  has_many :role_viewable_reasons
  has_many :viewable_reasons, :through => :role_viewable_reasons ,  :source => :reason
  
  has_many :role_assignable_actions
  has_many :assignable_actions, :through => :role_assignable_actions, :source => :action_type
  
  has_many :role_viewable_actions
  has_many :viewable_actions, :through => :role_viewable_actions, :source => :action_type
  
  has_many :role_selectable_actions
  has_many :selectable_actions, :through => :role_selectable_actions, :source => :action_type
  # I think you need to name the association because role joins to reason and action multiple times
  
  has_many :people_roles
  has_many :people, :through => :people_roles
  
  belongs_to :default_assignee, :class_name => 'Person'
  
  accepts_nested_attributes_for :people_roles, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :people, :reject_if => :all_blank, :allow_destroy => true
  
end
