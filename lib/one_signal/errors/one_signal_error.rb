module OneSignal
  class OneSignalError < StandardError
    attr_reader :message
    attr_reader :original_message
    attr_reader :http_status
    attr_reader :http_body

    def initialize(message: nil, http_status: nil, http_body: nil)
      @message = message
      @original_message = message
      @http_status = http_status
      @http_body = http_body
      @message += " - http status : #{@http_status}" unless @http_status.nil?
      @message += " - http body : #{@http_body}" unless @http_body.nil?
      super(@message)
    end

  end
end
