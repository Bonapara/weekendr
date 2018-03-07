class Bookmark < ApplicationRecord
  belongs_to :weekend
  belongs_to :user
  has_many :list_users
  # # validations
  # validates :user,        presence: true
  # validates :weekend,     presence: true
end
