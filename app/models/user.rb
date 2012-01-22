class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation 
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence=>true,
                    :length => { :maximum=> 50 }
                    
  validates :email, :presence=>true,
                    :format => { :with=>email_regex },
                    :uniqueness => { :case_sensitive => false}
                    
  validates :password,  :presence=>true,
                        :length => {:within=>6..40},
                        :confirmation => true
                        
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    #compare encrypted password with submitted password
    encrypted_password==encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    valid_user=User.find_by_email(email)
    if valid_user
      valid_user.has_password?(submitted_password)
    else
      valid_user=nil
    end
    valid_user
  end
  
  private
  
  def encrypt_password
    self.salt = make_salt unless has_password?(password)
    self.encrypted_password = encrypt(password)
  end
  
  def make_salt
    secure_hash "#{Time.now.utc}--#{password}"
  end
  
  def encrypt(str)
    secure_hash "#{salt}--#{str}"
  end
  
  def secure_hash(str)
    Digest::SHA2.hexdigest(str)
  end
  
end
