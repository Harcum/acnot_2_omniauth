class ReasonField < ApplicationRecord
  belongs_to :reason
  has_many :reason_field_choices
end
