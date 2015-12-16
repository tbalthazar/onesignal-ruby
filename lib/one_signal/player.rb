module OneSignal

  class Player < OneSignal

    def self.csv_export(app_id:)
      uri_string = @@base_uri
      uri_string += "/players/csv_export"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: {app_id: app_id})

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'CSV Export',
                         uri: uri,
                         params: {})

      return response
    end

    def self.create(params: {})
      uri_string = @@base_uri
      uri_string += "/players"
      uri = URI.parse(uri_string)

      response = send_post_request(uri: uri, body: params)

      ensure_http_status(response: response,
                         status: '200',
                         method_name: 'Create',
                         uri: uri,
                         params: params)

      return response
    end

    def self.update(id:, params: {})
      uri_string = @@base_uri
      uri_string += "/players"
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

    def self.ensure_http_status(response:, status:, method_name:, uri:, params:)
      if response.code != status.to_s
        msg = "#{method_name} Player error - uri: #{uri} params: #{params}"
        raise OneSignalError.new(message: msg,
                                 http_status: response.code,
                                 http_body: response.body)
      end
    end

  end

end
