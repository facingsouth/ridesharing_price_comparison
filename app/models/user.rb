class User < ActiveRecord::Base
  validates :name, :email, :password, :presence => true
  validates :email, length: {in:4..30}
  has_secure_password
end
