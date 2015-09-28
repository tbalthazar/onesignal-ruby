require 'net/http'
require 'uri'
require 'json'

module OneSignal

  class OneSignal
    @@base_uri = "https://onesignal.com/api/v1"
    @@api_key = nil

    def self.api_key=(new_api_key)
      @@api_key = new_api_key
    end

    def self.api_key
      @@api_key
    end

    def initialize
      unless @@api_key && !@@api_key.strip.empty?
        msg = "No API provided"
        raise OneSignalError.new(message: msg)
      end
    end

    def self.build_post_request(uri:, body:)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body.to_json
      request.add_field("Content-Type", "application/json")
      request.add_field("Authorization", "Basic #{@@api_key}")
      return request
    end

    def self.build_http_object(uri:)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      return http
    end

  end

end
