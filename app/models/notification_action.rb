class NotificationAction < ApplicationRecord
  belongs_to :notification
  belongs_to :action_status
  belongs_to :action_type
  belongs_to :creator, :class_name => 'Person', :foreign_key => 'created_by'
  belongs_to :assignee, :class_name => 'Person', :foreign_key => 'assigned_to'
  serialize :fields, Hash
  

  def display
   "#{action_type.code.ljust(20)} due on: #{due_date.to_date} status: #{action_status.code} assigned to: #{assignee.first_name} #{assignee.last_name}"
   end
  
end
