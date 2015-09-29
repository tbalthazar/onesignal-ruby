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

    def self.send_post_request(uri:, body:)
      unless @@api_key && !@@api_key.strip.empty?
        msg = "No API key provided"
        raise OneSignalError.new(message: msg)
      end

      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = body.to_json
      request.add_field("Content-Type", "application/json")
      request.add_field("Authorization", "Basic #{@@api_key}")
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'

      response = http.request(request)
    end

  end

end
