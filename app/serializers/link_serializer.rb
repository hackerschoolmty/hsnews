class LinkSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  has_one :user, serializer: PublicUserSerializer

  attributes :id, :title, :url, :created_at, :links

  def links
    {
      comments: api_link_comments_url(object)
    }
  end
end
