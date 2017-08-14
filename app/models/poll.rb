# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Poll Model (Poll)
#
# Authors:

class Poll < ApplicationRecord
  belongs_to :event
  has_many :options, dependent: :destroy
end
