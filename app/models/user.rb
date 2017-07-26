class User < ApplicationRecord
    has_many :sent_requests, :class_name => :Friend, :foreign_key => 'user_sender'
    has_many :received_requests, :class_name => :Friend, :foreign_key => 'user_receiver'
    
    attr_accessor :password

    before_save :encrypt_password
    after_save :clear_password

    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/

    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :preferred_name, :presence => true, :length => { :in => 3..20 }
    validates :password, :confirmation => true
    validates :phone, :format => PHONE_REGEX
    
    #Only on Create so other actions like update password attribute can be nil
    
    validates_length_of :password, :in => 6..20, :on => :create
    
    attr_accessor :username, :email, :password, :password_confirmation
    
    def self.authenticate(login_email="", login_password="") #login_email was username_or_email

        if  EMAIL_REGEX.match(login_email)    
            user = User.find_by_email(login_email)
        end
    
        if user && user.match_password(login_password)
            return user
        else
            return false
        end
    
    end   
    
    def match_password(login_password="")
    
        encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
    
    end
    
    def encrypt_password
    
        unless password.blank?
    
            self.salt = BCrypt::Engine.generate_salt
    
            self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    
        end
    end
    
    
    def clear_password
    
        self.password = nil
    
    end
end
