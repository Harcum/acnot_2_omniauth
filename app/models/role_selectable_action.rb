class RoleSelectableAction < ApplicationRecord
  belongs_to :role
  belongs_to :action_type
end
