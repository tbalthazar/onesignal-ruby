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

    # the mock request returned by OneSignal.build_post_request
    request_mock = MiniTest::Mock.new

    # the mock http object returned by OneSignal.build_http_object
    # expect that http.request(request) will be called
    http_mock = MiniTest::Mock.new
    http_mock.expect(:request, nil, [request_mock])

    # expect that OneSignal.build_post_request will be called
    build_post_request_params = {uri: uri, body: @create_params}
    build_post_request_mock = MiniTest::Mock.new
    build_post_request_mock.expect(:call, request_mock, [build_post_request_params])

    build_http_object_params = {uri: uri}
    build_http_object_mock = MiniTest::Mock.new
    build_http_object_mock.expect(:call, http_mock, [build_http_object_params ]) 

    OneSignal::OneSignal.stub(:build_post_request, build_post_request_mock) do
      OneSignal::OneSignal.stub(:build_http_object, build_http_object_mock) do
        OneSignal::Player.create(@create_params)
      end
    end

    build_post_request_mock.verify
    build_http_object_mock.verify
  end

end
