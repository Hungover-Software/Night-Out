# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Poll Model (Poll)
# A poll belongs to an event. Polls allow for different categories of Stops, like a stop for Food, Entertainment, who's House to go to, and so forth.
# Authors: Cal Mezzell

class Poll < ApplicationRecord
  belongs_to :event
  has_many :options, dependent: :destroy
  
  validates :name, :length => {:minimum => 1}
end
