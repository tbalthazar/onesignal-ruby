module OneSignal

  class Notification < OneSignal

    def self.all(params: {})
      uri_string = @@base_uri
      uri_string += "/notifications"
      uri = URI.parse(uri_string)

      response = send_get_request(uri: uri, params: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'All',
                         uri: uri,
                         params: params)

      return response
    end

    def self.get(id: "", params:)
      uri_string = @@base_uri
      uri_string += "/notifications"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)
    
      response = send_get_request(uri: uri, params: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Get',
                         uri: uri,
                         params: nil)

      return response
    end

    def self.create(params: {})
      uri_string = @@base_uri
      uri_string += "/notifications"
      uri = URI.parse(uri_string)
      
      response = send_post_request(uri: uri, body: params)

      if response.code != '200'
        handle_error(uri: uri, params: params, response: response)
      end

      return response
    end

    def self.update(id: "", params: {})
      uri_string = @@base_uri
      uri_string += "/notifications"
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

    def self.delete(id: "", params: {})
      uri_string = @@base_uri
      uri_string += "/notifications"
      uri_string += "/#{id}"
      uri = URI.parse(uri_string)
    
      response = send_delete_request(uri: uri, params: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Delete',
                         uri: uri,
                         params: nil)

      return response
    end

    private

    def self.handle_error(uri: nil, params: {}, response: nil)
      msg = "Create Notification error - uri: #{uri} params: #{params}"
      unless response.nil?
        code = response.code
        body = response.body
      end
      if is_no_recipients_error(response: response)
        raise NoRecipientsError.new(message: msg,
                                    http_status: code,
                                    http_body: body)
      else
        raise OneSignalError.new(message: msg,
                                 http_status: code,
                                 http_body: body)
      end
    end

    def self.is_no_recipients_error(response: nil)
      return false if response.nil? ||
                      response.code != '400' ||
                      response.body.nil?

      body = JSON.parse(response.body)
      return false unless body['errors'] &&
                          body['errors'].is_a?(Array) &&
                          !body['errors'].empty?

      expected_error_msg = "error: 0 recipients."
      return false unless body['errors'][0].strip.downcase == expected_error_msg

      return true
    end

  end

end
