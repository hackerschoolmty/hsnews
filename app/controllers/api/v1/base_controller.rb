class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  private

    def paginate(collection)
      collection.page(params[:page]).per(params[:per_page])
    end

    def meta_pagination(collection)
      {
        pagination: {
          per_page: params[:per_page] || 10,
          total_pages: collection.total_pages,
          total_objects: collection.total_count
        }
      }
    end
end
