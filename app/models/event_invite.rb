# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: EventInvite Model (EventInvite)
#
# Authors:

class EventInvite < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
