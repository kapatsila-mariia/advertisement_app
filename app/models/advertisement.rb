class Advertisement < ApplicationRecord
  belongs_to :user
  has_many :comments

  def as_json(options)
    super(only: [:title, :description, :status],
          include: [user: { only: [:id, :login] }])
  end
  
end
