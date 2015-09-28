require 'one_signal'
require 'dotenv'

Dotenv.load
api_key = ENV['ONESIGNAL_API_KEY']
app_id = ENV['ONESIGNAL_APP_ID']
device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabc3"

OneSignal::OneSignal.api_key = api_key

params = {
  app_id: app_id,
  device_type: 0,
  identifier: device_token,
  tags: {
    user_id: 'test2'
  }
}

begin 
  response = OneSignal::Player.create(params)
  puts "code : #{response.code}"
  puts "message : #{response.message}"
  puts "body : #{response.body}"
rescue OneSignal::OneSignalError => e
  puts "-- message : #{e.message}"
  puts "-- status : #{e.http_status}"
  puts "-- body : #{e.http_body}"
end

