class PeopleTerm < ApplicationRecord
  self.primary_key = 'id'
  belongs_to :person
  belongs_to :term
  has_many :transcript_gpas
  has_many :transcript_grades
  has_many :charge_credits
  has_many :hist_attendances
end

