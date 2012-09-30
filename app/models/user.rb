class User < ActiveRecord::Base
  attr_accessible :email, :login, :password, :password_confirmation
  has_secure_password

  validates :login, presence: true, uniqueness: true
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :auth_secret, presence: true

  after_save { |user| create_role(user)}
  before_save { |user| user.email = email.downcase }
  before_validation :assign_auth_secret, on: :create

  has_one :role, dependent: :destroy
  accepts_nested_attributes_for :role

  has_many :sessions
  accepts_nested_attributes_for :sessions

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

   def assign_auth_secret
     self.auth_secret = ROTP::Base32.random_base32
   end
end
