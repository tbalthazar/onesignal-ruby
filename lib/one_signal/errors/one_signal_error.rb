module OneSignal
  class OneSignalError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :http_body

    def initialize(message: nil, http_status: nil, http_body: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      message_string = @mesage.nil? ? "" : "Message : #{@message} "
      body_string = @http_body.nil? ? "" : "Body : #{@http_body} "
      "#{status_string}#{@message}#{body_string}"
    end
  end
end
