module OneSignal

  class Notification < OneSignal

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

    private

    def self.handle_error(uri:, params:, response:)
      msg = "Create Notification error - uri: #{uri} params: #{params}"
      if is_no_recipients_error(response: response)
        raise NoRecipientsError.new(message: msg,
                                    http_status: response.code,
                                    http_body: response.body)
      else
        raise OneSignalError.new(message: msg,
                                 http_status: response.code,
                                 http_body: response.body)
      end
    end

    def self.is_no_recipients_error(response:)
      return false if response.code != '400' ||
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
