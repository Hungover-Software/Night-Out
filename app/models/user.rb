class User < ApplicationRecord
    has_many :sent_requests, :class_name => :Friend, :foreign_key => 'user_sender'
    has_many :received_requests, :class_name => :Friend, :foreign_key => 'user_receiver'
end
