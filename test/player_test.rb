require File.dirname(__FILE__) + '/helper'

class PlayerTest < MiniTest::Test

  def setup
    @create_params = {
      foo: "bar",
      widget: "acme"
    }
    @api_key = "fake api key"
  end

  def test_create_sends_requests_with_params
    uri = URI.parse("https://onesignal.com/api/v1/players")
    expect_post_request uri: uri, params: @create_params, http_status: "200" do 
      OneSignal::Player.create(@create_params)
    end
  end

  def test_create_raises_error
    uri = URI.parse("https://onesignal.com/api/v1/players")
    expect_post_request uri: uri, params: @create_params, http_status: "400" do 
      assert_raises OneSignal::OneSignalError do
        OneSignal::Player.create(@create_params)
      end
    end
  end

end
