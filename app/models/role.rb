class Role < ActiveRecord::Base
  attr_accessible :role_of_user

  belongs_to :user
  validates :user_id, presence: true
end
