require File.dirname(__FILE__) + '/helper'

class NotificationTest < MiniTest::Test

  def setup
    @uri = URI.parse("https://onesignal.com/api/v1/notifications")
    @create_params = {
      foo: "bar",
      widget: "acme"
    }
    @api_key = "fake api key"
    OneSignal::OneSignal.api_key = @api_key
  end

  def test_create_raises_error    
    response = mock_response_ko
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @uri, body: @create_params)
                        .returns(response)
    assert_raises OneSignal::OneSignalError do
      OneSignal::Notification.create(@create_params)
    end
  end

  def test_create
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @uri, body: @create_params)
                        .returns(response)
    assert_equal response, OneSignal::Notification.create(@create_params)
  end

end
