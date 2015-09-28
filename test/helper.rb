$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'minitest/autorun'
require 'mocha/mini_test'
require 'one_signal'

def mock_response_ok
  response = mock()
  response.expects(:code).returns("200")
  return response
end

def mock_response_ko
  response = mock()
  response.expects(:code).returns("400").twice
  response.expects(:body)
  return response
end
