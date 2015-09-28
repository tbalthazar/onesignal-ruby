module OneSignal

  class Player < OneSignal

    def self.create(params = {})
      # body = { text_list: text_list }

      uri_string = @@base_uri
      uri_string += "/players"
      uri = URI.parse(uri_string)

      request = build_post_request(uri: uri, body: params)
      http = build_http_object(uri: uri)
      
      response = http.request(request)
    end

  end

end
