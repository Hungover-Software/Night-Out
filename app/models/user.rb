# Night Out event planning application
# Hungover Software
# University of Nebraska Omaha
# CSCI-4830-860 SU17
# Class: User Model (User)
# This model validates the input from the createaccount/new.html.erb web form for account signup.
# Authors: Nathan Lyon, Biraj Parajuli

class User < ApplicationRecord
    has_many :sent_requests, :class_name => :Friend, :foreign_key => 'user_sender'
    has_many :received_requests, :class_name => :Friend, :foreign_key => 'user_receiver'
    has_many :events
    has_many :event_invites, dependent: :destroy
    has_many :comments
    has_many :options
    has_many :votes, dependent: :destroy

    has_secure_password
    
    # Constant EMAIL_REGEX
    # regex for checking if an email address is in the valid form: string@string.str
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    
    #Constant PHONE_REGEX
    # regex for checking if a phone number is valid
    PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/

    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :preferred_name, :presence => true, :length => { :in => 3..20 }
    validates :phone, :format => PHONE_REGEX
    validates :password, :presence => true, :confirmation => true, :length => {:within => 6..30}, :on => :create

end
