class TranscriptGpa < ApplicationRecord
  belongs_to :person
  belongs_to :term
end
