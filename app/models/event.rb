=begin
Night Out event planning application

Hungover Software

University of Nebraska Omaha

CSCI-4830-860 SU17

Class: Event Model (Event)

An Event is an entire Night Out that a group of people plan to have. Keeps track of the date, time, name of the event, and the name of the owner.

Authors: Cal Mezzell
=end

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
