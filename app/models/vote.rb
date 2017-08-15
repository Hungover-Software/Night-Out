# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Vote Model (Vote)
# A vote keeps track of what user voted for what option.
# Authors: Cal Mezzell

class Vote < ApplicationRecord
  belongs_to :option
  belongs_to :user
end
