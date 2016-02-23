require 'one_signal'
require 'dotenv'

# load your keys with https://github.com/bkeepers/dotenv
Dotenv.load
api_key = ENV['ONESIGNAL_API_KEY']
user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']

# configure OneSignal
OneSignal::OneSignal.api_key = api_key
OneSignal::OneSignal.user_auth_key = user_auth_key

# create app
params = {
  name: 'test-app'
}
response = OneSignal::App.create(params: params)
app_id = JSON.parse(response.body)["id"]
puts "--- created app id: #{app_id}"

# add a player
device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabc1"
params = {
  app_id: app_id,
  device_type: 0,
  identifier: device_token,
  tags: {
    user_id: '123'
  }
}
response = OneSignal::Player.create(params: params)
player_id = JSON.parse(response.body)["id"]
puts "--- created player id: #{player_id}"

# notify the player (this will fail because we haven't configured the app yet)
params = {
  app_id: app_id,
  contents: {
    en: 'hello player'
  },
  ios_badgeType: 'None',
  ios_badgeCount: 1,
  include_player_ids: [player_id]
}
begin
  response = OneSignal::Notification.create(params: params)
  notification_id = JSON.parse(response.body)["id"]
rescue OneSignal::OneSignalError => e
  puts "--- OneSignalError  :"
  puts "-- message : #{e.message}"
  puts "-- status : #{e.http_status}"
  puts "-- body : #{e.http_body}"
end
