require File.dirname(__FILE__) + '/helper'

class NotificationTest < MiniTest::Test

  def setup
    @notification_id = "fake-id-123"
    base_url = "https://onesignal.com/api/v1/notifications"
    @create_uri = URI.parse(base_url)
    @update_uri = URI.parse(base_url + "/#{@notification_id}")
    @delete_uri = URI.parse(base_url + "/#{@notification_id}")
    @all_uri = URI.parse(base_url)
    @get_uri = URI.parse(base_url + "/#{@notification_id}")
    @api_key = "fake api key 123"
    @api_key_2 = "fake api key 456"
    @params = {
      foo: "bar",
      widget: "acme"
    }
    @opts = {
      key1: "value1",
      key2: "vaue2",
      auth_key: @api_key_2
    }
    @default_opts = {
      auth_key: @api_key
    }
    OneSignal::OneSignal.api_key = @api_key
  end

  def test_all
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @all_uri, params: @params, opts: @default_opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.all(params: @params)
  end

  def test_all_with_auth_key
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @all_uri, params: @params, opts: @opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.all(params: @params,
                                                       opts: @opts)
  end

  def test_get
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @get_uri, params: @params, opts: @default_opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.get(id: @notification_id,
                                                       params: @params)
  end

  def test_get_with_auth_key
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @get_uri, params: @params, opts: @opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.get(id: @notification_id,
                                                       params: @params,
                                                       opts: @opts)
  end

  def test_create_raises_onesignal_error    
    response = mock_response_ko
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params, opts: @default_opts)
                        .returns(response)
    assert_raises OneSignal::OneSignalError do
      OneSignal::Notification.create(params: @params)
    end
  end

  def test_create_raises_no_recipients_error    
    response = mock_response_no_recipients
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params, opts: @default_opts)
                        .returns(response)
    assert_raises OneSignal::NoRecipientsError do
      OneSignal::Notification.create(params: @params)
    end
  end

  def test_create
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params, opts: @default_opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.create(params: @params)
  end

  def test_create_with_auth_key
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params, opts: @opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.create(params: @params, opts: @opts)
  end

  def test_update
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_put_request)
                        .with(uri: @update_uri, body: @params, opts: @default_opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.update(id: @notification_id,
                                                          params: @params)
  end

  def test_update_with_auth_key
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_put_request)
                        .with(uri: @update_uri, body: @params, opts: @opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.update(id: @notification_id,
                                                          params: @params,
                                                          opts: @opts)
  end

  def test_delete
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_delete_request)
                        .with(uri: @delete_uri, params: @params, opts: @default_opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.delete(id: @notification_id,
                                                          params: @params)
  end

  def test_delete_with_auth_key
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_delete_request)
                        .with(uri: @delete_uri, params: @params, opts: @opts)
                        .returns(response)
    assert_equal response, OneSignal::Notification.delete(id: @notification_id,
                                                          params: @params,
                                                          opts: @opts)
  end

end
