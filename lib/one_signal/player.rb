module OneSignal

  class Player < OneSignal

    def self.csv_export(params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players/csv_export"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'CSV Export',
                         uri: uri,
                         params: {})

      return response
    end

    def self.all(params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri = URI.parse(uri_string)

      response = send_get_request(uri: uri, params: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'All',
                         uri: uri,
                         params: params)

      return response
    end

    def self.get(id: "", opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)
    
      response = send_get_request(uri: uri, params: nil, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Get',
                         uri: uri,
                         params: nil)

      return response
    end

    def self.create(params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create',
                         uri: uri,
                         params: params)

      return response
    end

    def self.create_session(id: "", params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri_string += "/#{id}"
      uri_string += "/on_session"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create Session',
                         uri: uri,
                         params: params)

      return response
    end

    def self.create_purchase(id: "", params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri_string += "/#{id}"
      uri_string += "/on_purchase"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create Purchase',
                         uri: uri,
                         params: params)

      return response
    end

    def self.create_focus(id: "", params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri_string += "/#{id}"
      uri_string += "/on_focus"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create Focus',
                         uri: uri,
                         params: params)

      return response
    end

    def self.update(id: "", params: {}, opts: {})
      opts[:auth_key] ||= @@api_key

      uri_string = @@base_uri
      uri_string += "/players"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)

      response = send_put_request(uri: uri, body: params, opts: opts)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Update',
                         uri: uri,
                         params: params)

      return response
    end

  end

end
