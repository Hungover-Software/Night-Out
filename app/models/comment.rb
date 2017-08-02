class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user
  #has_one :commentator, class_name: "User", foreign_key: :user_id
end
