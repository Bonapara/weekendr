class Bookmark < ApplicationRecord
  belongs_to :weekend
  belongs_to :user
  # # validations
  # validates :user,        presence: true
  # validates :weekend,     presence: true
end
