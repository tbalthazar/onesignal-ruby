require File.dirname(__FILE__) + '/helper'
# require 'fakeweb'

class OneSignalTest < MiniTest::Test

  def setup
    @api_key = "fake_api_123"
    @body = "fake body"
    @uri = URI.parse("https://www.example.com/foo/bar")
  end

  def teardown
    OneSignal::OneSignal.api_key = nil
  end

  def test_build_request_with_nil_api_key_raises_an_error
    assert_raises OneSignal::OneSignalError do
      one_signal = OneSignal::OneSignal.new
    end
  end

  def test_build_request_with_empty_api_key_raises_an_error
    OneSignal::OneSignal.api_key = "  "
    assert_raises OneSignal::OneSignalError do
      one_signal = OneSignal::OneSignal.new
    end
  end

  def test_build_request_with_api_key
    OneSignal::OneSignal.api_key = @api_key
    refute_nil OneSignal::OneSignal.new
  end

  def test_build_post_request
    OneSignal::OneSignal.api_key = @api_key
    request = OneSignal::OneSignal.build_post_request(uri: @uri,
                                                      body: @body) 
    assert_equal "POST", request.method
    assert_equal @uri.path, request.path
    assert_equal @body.to_json, request.body
    assert_equal "application/json", request['Content-Type']
    assert_equal "Basic #{@api_key}", request['Authorization']
  end

  def test_build_http_object
    OneSignal::OneSignal.api_key = @api_key
    http = OneSignal::OneSignal.build_http_object(uri: @uri)
    refute_nil http
    assert_equal @uri.host, http.address
    assert_equal @uri.port, http.port
    use_ssl = @uri.scheme=='https'
    assert_equal use_ssl, http.use_ssl?
  end

end
