class PeopleRole < ApplicationRecord
  belongs_to :person
  belongs_to :role
  accepts_nested_attributes_for :person
end
