# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Option Model (Option)
# An option belongs to a poll. These are what the users are able to vote on.
# Authors: Cal Mezzell

class Option < ApplicationRecord
  belongs_to :user
  belongs_to :poll
  has_many :votes, dependent: :destroy
  
  validates :name, :length => {:minimum => 1}
end
