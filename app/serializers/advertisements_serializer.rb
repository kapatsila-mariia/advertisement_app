class AdvertisementsSerializer < ActiveModel::Serializer
  attributes  :title, :description, :status
  has_one :user
  has_many :comments
end
