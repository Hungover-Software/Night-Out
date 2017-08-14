# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: Option Model (Option)
#
# Authors:

class Option < ApplicationRecord
  belongs_to :user
  belongs_to :poll
  has_many :votes, dependent: :destroy
end
