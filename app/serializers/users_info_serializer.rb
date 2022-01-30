class UsersInfoSerializer < ActiveModel::Serializer
  attributes  :first_name, :last_name, :phone
  has_one :user
end
