class LinkSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :created_at
end
