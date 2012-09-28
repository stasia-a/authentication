class User < ActiveRecord::Base
  attr_accessible :email, :login

  before_save { |user| user.email = email.downcase }

  has_one :role, :dependent => :destroy
  accepts_nested_attributes_for :role

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true

end
