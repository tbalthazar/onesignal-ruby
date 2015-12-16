require File.dirname(__FILE__) + '/helper'

class PlayerTest < MiniTest::Test

  def setup
    base_url = "https://onesignal.com/api/v1/players"
    @create_uri = URI.parse(base_url)
    @csv_export_uri = URI.parse(base_url + "/csv_export")
    
    @player_id = "fake-id-123"
    @update_uri = URI.parse(base_url + "/#{@player_id}")

    @params = {
      foo: "bar",
      widget: "acme"
    }
    @api_key = "fake api key"
    OneSignal::OneSignal.api_key = @api_key
  end

  def test_create_raises_error
    response = mock_response_ko
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_raises OneSignal::OneSignalError do
      OneSignal::Player.create(params: @params)
    end
  end

  def test_csv_export
    @app_id = "foobar"
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @csv_export_uri, body: {app_id: @app_id})
                        .returns(response)
    assert_equal response, OneSignal::Player.csv_export(app_id: @app_id)
  end

  def test_create
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_post_request)
                        .with(uri: @create_uri, body: @params)
                        .returns(response)
    assert_equal response, OneSignal::Player.create(params: @params)
  end

  def test_update_raises_error
    response = mock_response_ko
    OneSignal::OneSignal.expects(:send_put_request)
                        .with(uri: @update_uri, body: @params)
                        .returns(response)
    assert_raises OneSignal::OneSignalError do
      OneSignal::Player.update(id: @player_id, params: @params)
    end
  end

  def test_update
    response = mock_response_ok
    OneSignal::OneSignal.expects(:send_put_request)
                        .with(uri: @update_uri, body: @params)
                        .returns(response)
    assert_equal response, OneSignal::Player.update(id: @player_id, params: @params)
  end

end
