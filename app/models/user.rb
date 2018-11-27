class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  VALID_PASSWORD_REGEX = /(\A.*\d.*[a-zA-Z].*\z)|(\A.*[a-zA-Z].*\d.*\z)/ #at least 1 alpha char, at least 1 digit
  validates :password, presence: true, length: { minimum: 8 },
                  format: { with: VALID_PASSWORD_REGEX}

# Returns the hash digest of the given string.
def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

#generate a new random, URL-safe token
def User.new_token
  SecureRandom.urlsafe_base64
end

#Creates a new remember token and updates the user's token digest in the DB
def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
end

#Returns true if the remember digest in the db matches the given token
def authenticated?(remember_token)
  return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
end

#Unwinds remember by setting :remember_digest to nil
def forget
  update_attribute(:remember_digest, nil)
end


end
