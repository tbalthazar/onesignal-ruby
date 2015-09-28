$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'minitest/autorun'
require 'one_signal'

def expect_post_request(uri:, params:, http_status:, &block)
  api_key = "fake api key"

  # the mock request returned by OneSignal.build_post_request
  request_mock = MiniTest::Mock.new

  # the mock response returned by http.request
  response_mock = MiniTest::Mock.new
  response_mock.expect(:code, http_status.to_s)
  if http_status != '200'
    response_mock.expect(:code, http_status.to_s)
    response_mock.expect(:body, nil)
  end

  # the mock http object returned by OneSignal.build_http_object
  # expect that http.request(request) will be called
  http_mock = MiniTest::Mock.new
  http_mock.expect(:request, response_mock, [request_mock])

  # expect that OneSignal.build_post_request will be called
  build_post_request_params = {uri: uri, body: params}
  build_post_request_mock = MiniTest::Mock.new
  build_post_request_mock.expect(:call, request_mock, [build_post_request_params])

  build_http_object_params = {uri: uri}
  build_http_object_mock = MiniTest::Mock.new
  build_http_object_mock.expect(:call, http_mock, [build_http_object_params]) 

  OneSignal::OneSignal.stub(:build_post_request, build_post_request_mock) do
    OneSignal::OneSignal.stub(:build_http_object, build_http_object_mock) do
      yield
    end
  end

  build_post_request_mock.verify
  build_http_object_mock.verify
end
