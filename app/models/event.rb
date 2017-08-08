class Event < ApplicationRecord
  belongs_to :user
  has_many :event_invites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :polls, dependent: :destroy
end
