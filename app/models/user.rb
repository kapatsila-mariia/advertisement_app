class User < ApplicationRecord
  has_one :users_info
  has_many :advertisements
  has_many :comments
  belongs_to :role
  
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
end
