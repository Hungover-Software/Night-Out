class Poll < ApplicationRecord
  belongs_to :event
  has_many :options, dependent: :destroy
end
