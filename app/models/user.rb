class User < ApplicationRecord
  has_one :users_info
  has_many :advertisements
  has_many :comments
  belongs_to :role

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
                      message: 'Wrong format' }
  validates :password, length: {minimum: 8, maximum: 20}, presence: true,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/,
                      message: 'must include upper and lowercase letters and digits' }
  validates :login,  presence: true, uniqueness: true, length: {minimum: 3, maximum:15}

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  def is_admin?
    self.role.name == "admin"
  end

end
