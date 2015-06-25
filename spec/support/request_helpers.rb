module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeaderHelpers
    def authorization_header(user_token, user_email)
      request.headers['Authorization'] = "Token token=#{user_token}; email=#{user_email}"
    end
  end
end
