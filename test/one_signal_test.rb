require File.dirname(__FILE__) + '/helper'

class OneSignalTest < MiniTest::Test

  def setup
    @api_key = "fake_api_123"
    @body = "fake body"
    @uri = URI.parse("https://www.example.com/foo/bar")
  end

  def teardown
    OneSignal::OneSignal.api_key = nil
  end

  def test_send_post_request_with_nil_api_key
    OneSignal::OneSignal.api_key = nil 
    assert_raises OneSignal::OneSignalError do
      OneSignal::OneSignal.send_post_request(uri: @uri, body: @body)
    end
  end
  
  def test_send_post_request_with_empty_api_key
    OneSignal::OneSignal.api_key = "  "
    assert_raises OneSignal::OneSignalError do
      OneSignal::OneSignal.send_post_request(uri: @uri, body: @body)
    end
  end

  def test_send_post_request
    # test request creation
    request = mock()
    request.expects(:body=).with(@body.to_json)
    request.expects(:add_field).with("Content-Type", "application/json")
    request.expects(:add_field).with("Authorization", "Basic #{@api_key}")
    Net::HTTP::Post.expects(:new).with(@uri.request_uri).returns(request)

    # test http object creation
    use_ssl = @uri.scheme == 'https'
    http = mock()
    http.expects(:use_ssl=).with(use_ssl)
    Net::HTTP.expects(:new).with(@uri.host, @uri.port).returns(http)

    # test send request
    response = mock()
    http.expects(:request).with(request).returns(response)

    OneSignal::OneSignal.api_key = @api_key
    assert_equal response, OneSignal::OneSignal.send_post_request(uri: @uri, body: @body)
  end

end
