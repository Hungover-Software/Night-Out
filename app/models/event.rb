class Event < ApplicationRecord
  belongs_to :user
  has_many :event_invites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :polls, dependent: :destroy
  
  validates :name, :presence => true
  validates :date, :presence => true
  validates :time, :presence => true
  validates :user_id, :presence => true
end
