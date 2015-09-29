module OneSignal

  class Notification < OneSignal

    def self.create(params = {})
      uri_string = @@base_uri
      uri_string += "/notifications"
      uri = URI.parse(uri_string)
      
      response = send_post_request(uri: uri, body: params)

      if response.code != '200'
        msg = "Create Notification error - uri: #{uri} params: #{params}"
        raise OneSignalError.new(message: msg,
                                 http_status: response.code,
                                 http_body: response.body)
      end

      return response
    end

  end

end
