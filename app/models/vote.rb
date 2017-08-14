# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Vote Model (Vote)
#
# Authors:

class Vote < ApplicationRecord
  belongs_to :option
  belongs_to :user
end
