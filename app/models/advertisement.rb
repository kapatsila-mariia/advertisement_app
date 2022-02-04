class Advertisement < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true,
            length: { minimum:5, maximum: 25, message: 'length must be from 5 to 25 symbols' }
  validates :description, presence: true,
            length: { minimum: 5, maximum: 150, message: 'length must be from 5 to 150 symbols'}

  def as_json(options)
    super(only: [:title, :description, :status],
          include: [user: { only: [:id, :login] }])
  end
  
end
