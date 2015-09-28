module OneSignal

  class Player < OneSignal

    def self.create(params = {})
      uri_string = @@base_uri
      uri_string += "/players"
      uri = URI.parse(uri_string)

      request = build_post_request(uri: uri, body: params)
      http = build_http_object(uri: uri)
      
      response = http.request(request)
      if response.code != '200'
        raise OneSignalError.new(message: "Post request error",
                                 http_status: response.code,
                                 http_body: response.body)
      end

      return response
    end

  end

end
