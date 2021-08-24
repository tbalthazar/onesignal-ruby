$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'minitest/autorun'
require 'mocha/minitest'
require 'one_signal'

def mock_response_ok
  response = mock()
  response.expects(:code).returns("200")
  return response
end

def mock_response_ko
  response = mock()
  response.expects(:code).returns("400").at_least_once
  response.expects(:body).at_least_once
  return response
end

def mock_response_no_recipients
  response = mock()
  response.expects(:code).returns("400").at_least_once
  response.expects(:body).returns('{"errors":["  Error: 0 Recipients."]}').at_least_once
  return response
end
