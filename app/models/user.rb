class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation
  has_secure_password

  after_save { |user| create_role(user)}
  before_save { |user| user.email = email.downcase }

  has_one :role, dependent: :destroy
  accepts_nested_attributes_for :role

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def create_role(user)
    user.build_role()
    if first_user?(user)
      user.role.update_attributes(role_of_user: "admin")
    else
      user.role.update_attributes(role_of_user: "user")
    end
  end

  private

  def first_user?(user)
    User.all.count == 1
  end


end
