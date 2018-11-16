class User < ApplicationRecord
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

end
