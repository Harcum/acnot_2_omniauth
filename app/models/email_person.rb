class EmailPerson < ApplicationRecord
  belongs_to :person
  belongs_to :email
end
