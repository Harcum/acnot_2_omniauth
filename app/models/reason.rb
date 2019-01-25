class Reason < ApplicationRecord
  has_many :reason_fields
  accepts_nested_attributes_for :reason_fields, allow_destroy: true
end
