module OneSignal
  
  class App < OneSignal

    def self.all(params: {})
      uri_string = @@base_uri
      uri_string += "/apps"
      uri = URI.parse(uri_string)

      response = send_get_request(uri: uri, params: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'All',
                         uri: uri,
                         params: params)

      return response
    end

    def self.get(id: "")
      uri_string = @@base_uri
      uri_string += "/apps"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)
    
      response = send_get_request(uri: uri, params: nil)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Get',
                         uri: uri,
                         params: nil)

      return response
    end

    def self.create(params: {})
      uri_string = @@base_uri
      uri_string += "/apps"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create',
                         uri: uri,
                         params: params)

      return response
    end
    
    def self.update(id: "", params: {})
      uri_string = @@base_uri
      uri_string += "/apps"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)

      response = send_put_request(uri: uri, body: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Update',
                         uri: uri,
                         params: params)

      return response
    end

    private

    def self.auth_key
      return @@user_auth_key
    end

  end

end
