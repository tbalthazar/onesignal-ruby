require 'one_signal'
require 'dotenv'

Dotenv.load
api_key = ENV['ONESIGNAL_API_KEY']
@app_id = ENV['ONESIGNAL_APP_ID']
@device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabc3"

OneSignal::OneSignal.api_key = api_key

def create_player
  params = {
    app_id: @app_id,
    device_type: 0,
    identifier: @device_token,
    tags: {
      user_id: 'test2',
      device_type: 'chrome'
    }
  }

  begin 
    response = OneSignal::Player.create(params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
    puts "id : #{JSON.parse(response.body).class}"
    return JSON.parse(response.body)["id"]
  rescue OneSignal::OneSignalError => e
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  end
end

def update_player(id:)
  params = {
    app_id: @app_id,
    device_type: 0,
    identifier: @device_token,
    tags: {
      user_id: 'test2updated',
      device_type: 'chrome'
    }
  }

  begin 
    response = OneSignal::Player.update(id: id, params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
    puts "id : #{JSON.parse(response.body).class}"
  rescue OneSignal::OneSignalError => e
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  end
end

def notify
  params = {
    app_id: @app_id,
    contents: {
      en: 'hey buddy'
    },
    ios_badgeType: 'None',
    ios_badgeCount: 1,
    tags: [
      {
        key: 'user_id',
        relation: '=',
        value: "unknown"
      },
      { operator: 'AND' },
      {
        key: 'device_type',
        relation: '=',
        value: 'ios'
      }
    ]
  }

  begin 
    response = OneSignal::Notification.create(params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
  rescue OneSignal::NoRecipientsError => e
    puts "--- NoRecipientsError: #{e.inspect}"
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  rescue OneSignal::OneSignalError => e
    puts "--- OneSignalError  : #{e.inspect}"
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  end
end

# player_id = create_player
# update_player(id: player_id)
notify
