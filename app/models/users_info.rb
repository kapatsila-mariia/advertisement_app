class UsersInfo < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true,
            length: {minimum: 2, maximum: 20, message: 'length must be from 2 to 20 symbols'}
  validates :last_name, presence: true,
            length: {minimum: 2, maximum: 20, message: 'length must be from 2 to 20 symbols'}
  validates :phone, presence: true,
            length: {minimum: 10, maximum: 12, message: 'length must be from 10 to 12 digits'}
end
