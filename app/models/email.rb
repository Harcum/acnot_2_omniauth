class Email < ApplicationRecord
  belongs_to :notification
  belongs_to :not_action
  belongs_to :creator, :class_name => 'Person', :foreign_key => 'created_by'
  has_many :email_people
  has_many :people, :through => :email_people
end
