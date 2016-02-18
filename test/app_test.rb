require File.dirname(__FILE__) + '/helper'

class AppTest < MiniTest::Test

  def setup
    base_url = "https://onesignal.com/api/v1/apps"
    @app_id = "fake-id-123"
    @all_uri = URI.parse(base_url)
    @get_uri = URI.parse(base_url + "/#{@app_id}")
    @create_uri = URI.parse(base_url)
    @update_uri = URI.parse(base_url + "/#{@app_id}")

    @params = {
      foo: "bar",
      widget: "acme"
    }

    @user_auth_key = "fake user auth key"
    OneSignal::OneSignal.user_auth_key  = @user_auth_key 
  end

  def test_all
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @all_uri, params: @params)
                        .returns(response)
    assert_equal response, OneSignal::App.all(params: @params)
  end

  def test_get
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_get_request)
                        .with(uri: @get_uri, params: nil)
                        .returns(response)
    assert_equal response, OneSignal::App.get(id: @app_id)
  end

  def test_create
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_equal response, OneSignal::App.create(params: @params)
  end

  def test_update
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_put_request)
                        .with(uri: @update_uri, body: @params)
                        .returns(response)
    assert_equal response, OneSignal::App.update(id: @app_id, params: @params)
  end

end
