class Feedback < ApplicationRecord
  validates :email, :text, presence: true
end
