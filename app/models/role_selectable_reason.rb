class RoleSelectableReason < ApplicationRecord
  belongs_to :role
  belongs_to :reason
end
