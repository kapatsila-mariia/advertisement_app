class Comment < ApplicationRecord
  belongs_to :advertisement
  belongs_to :user

  def as_json(options={})
    super(only: [:comment_text],
          include: [user: { only: [:id, :login] }]
    )
  end
  
end
