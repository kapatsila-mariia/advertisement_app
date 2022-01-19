class User < ApplicationRecord
  has_one :users_info
  has_many :advertisements
  belongs_to :role
end
