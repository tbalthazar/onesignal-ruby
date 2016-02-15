require File.dirname(__FILE__) + '/helper'

class NotificationTest < MiniTest::Test

  def setup
    @notification_id = "fake-id-123"
    base_url = "https://onesignal.com/api/v1/notifications"
    @create_uri = URI.parse(base_url)
    @all_uri = URI.parse(base_url)
    @get_uri = URI.parse(base_url + "/#{@notification_id}")
    @params = {
      foo: "bar",
      widget: "acme"
    }
    @api_key = "fake api key"
    OneSignal::OneSignal.api_key = @api_key
  end

  def test_all
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @all_uri, params: @params)
                        .returns(response)
    assert_equal response, OneSignal::Notification.all(params: @params)
  end

  def test_get
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @get_uri, params: @params)
                        .returns(response)
    assert_equal response, OneSignal::Notification.get(id: @notification_id,
                                                       params: @params)
  end

  def test_create_raises_onesignal_error    
    response = mock_response_ko
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_raises OneSignal::OneSignalError do
      OneSignal::Notification.create(params: @params)
    end
  end

  def test_create_raises_no_recipients_error    
    response = mock_response_no_recipients
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_raises OneSignal::NoRecipientsError do
      OneSignal::Notification.create(params: @params)
    end
  end

  def test_create
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_equal response, OneSignal::Notification.create(params: @params)
  end

end
