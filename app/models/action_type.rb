class ActionType < ApplicationRecord
  belongs_to :role
  has_many :action_fields
  accepts_nested_attributes_for :action_fields, allow_destroy: true
end
