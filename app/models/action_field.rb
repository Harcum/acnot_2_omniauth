class ActionField < ApplicationRecord
  belongs_to :action_type
  has_many :action_field_choices
end
