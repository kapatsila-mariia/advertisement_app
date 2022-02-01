class CommentsSerializer < ActiveModel::Serializer
  attributes :comment_text
  has_one :advertisement
  has_one :user
end
