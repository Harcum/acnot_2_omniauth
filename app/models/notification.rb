class Notification < ApplicationRecord
  has_many :notification_reasons
  has_many :notification_viewers
  has_many :reasons, :through => :notification_reasons, :class_name => 'Reason'
  belongs_to :creator, :class_name => 'Person', :foreign_key => 'created_by'
  belongs_to :student, :class_name => 'Person', :foreign_key => 'person_id'
  belongs_to :student_attribute, :foreign_key => 'person_id'
  belongs_to :section, :class_name => 'SectionStudent', :foreign_key => 'section_student_id'
  belongs_to :status
    
  accepts_nested_attributes_for :notification_reasons, :reasons
    
  has_many :notification_actions
  has_many :emails
  has_many :notes
  has_many :action_types, :through => :notification_actions, :class_name => 'ActionType'
  has_many :action_statuses, :through => :notification_actions, :class_name => 'ActionStatus' 
  accepts_nested_attributes_for :notification_actions, :action_types, :action_statuses, :emails, :notes 
  
  # def are_open_actions   
   #   notification_actions.where(assigned_to: @current_user_id,status: 1).count > 1
   #end
  
  
  
end
