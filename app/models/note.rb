class Note < ApplicationRecord
  belongs_to :notification
  belongs_to :creator, :class_name => 'Person', :foreign_key => 'created_by'
end
