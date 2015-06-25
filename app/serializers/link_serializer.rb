class LinkSerializer < ActiveModel::Serializer
  has_one :user, serializer: PublicUserSerializer

  attributes :id, :title, :url, :created_at
end
