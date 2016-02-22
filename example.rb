require 'one_signal'
require 'dotenv'

Dotenv.load
api_key = ENV['ONESIGNAL_API_KEY']
user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
@app_id = ENV['ONESIGNAL_APP_ID']
@device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabc3"
@example_player_id = ENV['EXAMPLE_PLAYER_ID']

OneSignal::OneSignal.api_key = api_key
OneSignal::OneSignal.user_auth_key = user_auth_key

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

def create_player_session(id:)
  params = {
    # app_id: @app_id,
    # device_type: 0,
    # identifier: @device_token,
    # tags: {
    #   user_id: 'test2',
    #   device_type: 'chrome'
    # }
    device_os: 'iPhone5,1',
    game_version: '1.0.6',
    timezone: -28800
  }

  begin 
    response = OneSignal::Player.create_session(id: id, params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
  rescue OneSignal::OneSignalError => e
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  end
end

def create_player_purchase(id:)
  params = {
    purchases: [
      {
        sku: 'SKU123',
        iso: 'USD',
        amount: '0.99'
      }
    ]
  }

  begin 
    response = OneSignal::Player.create_purchase(id: id, params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
  rescue OneSignal::OneSignalError => e
    puts "-- message : #{e.message}"
    puts "-- status : #{e.http_status}"
    puts "-- body : #{e.http_body}"
  end
end

def create_player_focus(id:)
  params = {
    state: 'ping',
    active_time: 60
  }

  begin 
    response = OneSignal::Player.create_focus(id: id, params: params)
    puts "code : #{response.code}"
    puts "message : #{response.message}"
    puts "body : #{response.body}"
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

def all_notifs
  params = {
    app_id: @app_id,
    limit: 5,
    offset: 0
  }

  begin 
    response = OneSignal::Notification.all(params: params)
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

def get_notif(id:)
  params = {
    app_id: @app_id
  }

  begin 
    response = OneSignal::Notification.get(id: id, params: params)
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
        value: "2"
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
    body = JSON.parse(response.body)
    return body["id"]
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

def csv_export
  response = OneSignal::Player.csv_export(app_id: @app_id)
  puts response.body
end

def all_players
  response = OneSignal::Player.all(params: {app_id: @app_id, limit: 3})
  puts response.body
end

def get_player(id:)
  response = OneSignal::Player.get(id: id)
  puts response.body
end

def update_notif(id:)
  params = {
    app_id: @app_id,
    opened: true
  }
  response = OneSignal::Notification.update(id: id, params: params)
  puts response.body
end

def delete_notif(id:)
  params = {
    app_id: @app_id
  }

  begin 
    response = OneSignal::Notification.delete(id: id, params: params)
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

def all_apps
  begin 
    response = OneSignal::App.all(params: nil)
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

def get_app(id:)
  response = OneSignal::App.get(id: id)
  puts response.body
end

def create_app
  params = {
    name: 'footest'
  }
  response = OneSignal::App.create(params: params)
  puts response.body
end

def update_app
  params = {
    name: 'bartest'
  }
  response = OneSignal::App.update(id: "29203a07-8f1f-438a-9932-9549c6b28c14",
                                   params: params)
  puts response.body
end

# player_id = create_player
# update_player(id: player_id)
player_id = '9c9a3fb4-62e0-455d-865b-670ccea594a1' 
notification_id = 'c6e10bac-af7d-4879-a5e9-439de53e3cff'
# create_player_session(id: player_id)
# create_player_purchase(id: player_id)
# create_player_focus(id: player_id)
# notification_id = notify
# puts "--- notif id: #{notification_id}"
# csv_export
# all_players
# get_player(id: player_id)
# all_notifs
# get_notif(id: notification_id)
# delete_notif(id: notification_id)
# update_notif(id: notification_id)
# get_notif(id: notification_id)
# all_apps
# get_app(id: @app_id)
# create_app
update_app
