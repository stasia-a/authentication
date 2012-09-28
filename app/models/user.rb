class User < ActiveRecord::Base
  attr_accessible :email, :login

  has_one :role, :dependent => :destroy
  accepts_nested_attributes_for :role

  validates :email,:login, presence: true

end
