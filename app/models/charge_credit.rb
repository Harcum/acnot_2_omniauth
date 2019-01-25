class ChargeCredit < ApplicationRecord
  belongs_to :people_term
  belongs_to :person
  belongs_to :term
end
