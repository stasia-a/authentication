class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  has_one :role, :dependent => :destroy
  accepts_nested_attributes_for :role

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end
