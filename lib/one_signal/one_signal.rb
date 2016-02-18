require 'net/http'
require 'uri'
require 'json'

module OneSignal

  class OneSignal
    @@base_uri = "https://onesignal.com/api/v1"
    @@api_key = nil
    @@user_auth_key = nil
    @@open_timeout = 30
    @@read_timeout = 30

    def self.api_key=(new_api_key)
      @@api_key = new_api_key
    end

    def self.api_key
      @@api_key
    end

    def self.user_auth_key=(new_user_auth_key)
      @@user_auth_key = new_user_auth_key
    end

    def self.user_auth_key
      @@user_auth_key
    end

    def self.open_timeout=(new_timeout)
      @@open_timeout = new_timeout
    end

    def self.open_timeout
      @@open_timeout
    end

    def self.read_timeout=(new_timeout)
      @@read_timeout = new_timeout
    end

    def self.read_timeout
      @@read_timeout
    end

    def self.http_object(uri:)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.open_timeout = @@open_timeout
      http.read_timeout = @@read_timeout
      return http
    end

    def self.send_post_request(uri:, body:)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body.to_json
      request = request_with_headers(request: request)
      
      http = http_object(uri: uri)

      response = http.request(request)
    end

    def self.send_delete_request(uri:, params: {})
      uri.query = URI.encode_www_form(params) unless params.nil?
      request = Net::HTTP::Delete.new(uri.request_uri)
      request = request_with_headers(request: request)
      
      http = http_object(uri: uri)

      response = http.request(request)
    end

    def self.send_put_request(uri:, body:)
      request = Net::HTTP::Put.new(uri.request_uri)
      request.body = body.to_json
      request = request_with_headers(request: request)
      
      http = http_object(uri: uri)

      response = http.request(request)
    end

    def self.send_get_request(uri:, params: {})
      uri.query = URI.encode_www_form(params) unless params.nil?
      request = Net::HTTP::Get.new(uri.request_uri)
      request = request_with_headers(request: request)
      
      http = http_object(uri: uri)

      response = http.request(request)
    end

    private

    def self.ensure_http_status(response:, status:, method_name:, uri:, params:)
      if response.code != status.to_s
        msg = "#{self.name}##{method_name} error - uri: #{uri} params: #{params}"
        raise OneSignalError.new(message: msg,
                                 http_status: response.code,
                                 http_body: response.body)
      end
    end

    def self.request_with_headers(request:)
      request.add_field("Content-Type", "application/json")
      request.add_field("Authorization", "Basic #{self.auth_key}")
      return request
    end

    def self.auth_key
      return @@api_key
    end

  end

end
