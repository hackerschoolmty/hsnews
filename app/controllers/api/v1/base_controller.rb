class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  protected

    def authenticate!
      authenticate_with_token || render_unauthorized
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { errors: "Invalid session data" },
        status: :unauthorized
    end

    def authenticate_with_token
      authenticate_with_http_token do |token, options|
        # Token token=2a4s5d6ft7ybiu; email=email@example.com
        user_email = options[:email]
        user = User.find_by(email: user_email) if user_email.present?

        if user && secure_token_compare(user.auth_token, token)
          @current_user = user
        end
      end
    end

    def current_user
      @current_user
    end

    #def is_owner?
      #resource_name = request.path.split('/')[2]
      #klass = resource_name.singularize.classify.constantize.find(params[:id])

      #render_unauthorized if klass.user_id != current_user.id
    #end

  private

    # constant-time comparison algorithm to prevent timing attacks
    # Thanks devise
    def secure_token_compare(a, b)
      return false if a.blank? || b.blank? || a.bytesize != b.bytesize
      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

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
