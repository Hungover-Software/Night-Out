class User < ApplicationRecord
 

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
        if( encrypt_password == login_password)
            return true
        end
        else
            return false
        end
    
    end
    
    def encrypt_password(new_password="")
    
        
    
            salt = BCrypt::Engine.generate_salt
    
            encrypted_password = BCrypt::Engine.hash_secret(new_password, salt)
            return encrypted_password
    
    end
    
    
    def clear_password
    
        self.password = nil
    
    end

