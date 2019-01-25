class NotificationReason < ApplicationRecord
  belongs_to :reason
  belongs_to :notification
  serialize :fields, Hash
end
