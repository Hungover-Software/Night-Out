class User < ApplicationRecord
    has_many :sent_requests, :class_name => :Friend, :foreign_key => 'user_sender'
    has_many :received_requests, :class_name => :Friend, :foreign_key => 'user_receiver'

    has_secure_password

    #before_save :encrypt_password
    #after_save :clear_password

    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    #/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/

    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :preferred_name, :presence => true, :length => { :in => 3..20 }
    validates :phone, :format => PHONE_REGEX
    
    validates :password, :presence => true,
                   :confirmation => true,
                   :length => {:within => 6..30},
                   :on => :create
    #Only on Create so other actions like update password attribute can be nil
    
    #validates_length_of :password, :in => 6..20, :on => :create
    
    #attr_accessor :email, :password, :password_confirmation, :preferred_name, :phone
    
=begin
    def self.authenticate(email, password)

        user = User.find_by_email(email)

        if user && user.match_password(password)
            return user
        else
            return false
        end
    end 
    
    def match_password(password="")
        self.password_digest == BCrypt::Engine.hash_secret(password, salt)
    end
    
    def encrypt_password
        unless password.blank?
            self.salt = BCrypt::Engine.generate_salt
            self.password = BCrypt::Engine.hash_secret(password, salt)
        end
    end
    
    
    def clear_password
        self.password = nil
    end
=end

end
