class Comment < ApplicationRecord
  belongs_to :advertisement
  belongs_to :user

  validates :comment_text, presence: true, 
            length: { minimum:2, maximum: 50, message: 'length must be from 2 to 50 symbols'}

  def as_json(options={})
    super(only: [:comment_text],
          include: [user: { only: [:id, :login] }]
    )
  end
  
end
