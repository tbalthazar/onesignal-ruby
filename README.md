# OneSignal Ruby bindings

This gem provides a simple SDK to access the [OneSignal API](https://documentation.onesignal.com/reference).

Also check my [onesignal-go](https://github.com/tbalthazar/onesignal-go) library.

## Installation

```
gem install one_signal
```

## Development

Run the tests

```
bundle exec rake
```

## Basic usage

See basic examples in [example.rb](/example.rb).
To run it:
- rename [.env.example](/.env.example) into `.env`
- set your `USER_AUTH_KEY` and `API_KEY` in the `.env` file
- run `ruby example.rb`

## Documentation

Specify your User Auth key to deal with Apps:

```ruby
OneSignal::OneSignal.user_auth_key = YOUR_USER_AUTH_KEY
```

Specify your API key to deal with Players and Notifications:

```ruby
OneSignal::OneSignal.api_key = YOUR_API_KEY
```

Then call the following methods on the `App`, `Player` and `Notification` classes.
The `params` argument in those methods is a ruby hash and the accepted/required keys for this hash are documented in the [OneSignal API documentation](https://documentation.onesignal.com/reference)

Each method also accepts an optional `opts` hash that allows you to specify the `user_auth_key`/`api_key` on a per method basis. It allows a ruby app to talk to several different OneSignal apps:

```ruby
app_1_api_key = "fake api key 1"
app_2_api_key = "fake api key 2"

# by default, method calls will use app_1_api_key
OneSignal::OneSignal.api_key = app_1_api_key

# get player with id "123" in app_1
OneSignal::Player.get(id: "123")

# get player with id "456" in app_2
OneSignal::Player.get(id: "123", opts: {auth_key: app_2_api_key})
```

The return value of each method is a `Net::HTTPResponse`.

### Apps

```ruby
- OneSignal::App.all(params:)
- OneSignal::App.get(id:)
- OneSignal::App.create(params:)
- OneSignal::App.update(id:, params:)
```

### Players

```ruby
- OneSignal::Player.all(params:)
- OneSignal::Player.csv_export(params:)
- OneSignal::Player.get(id:)
- OneSignal::Player.create(params:)
- OneSignal::Player.create_session(id:, params:)
- OneSignal::Player.create_purchase(id:, params:)
- OneSignal::Player.create_focus(id:, params:)
- OneSignal::Player.update(id:, params:)
- OneSignal::Player.delete(id:, params:)
```

### Notifications

```ruby
- OneSignal::Notification.all(params:)
- OneSignal::Notification.get(id:, params:)
- OneSignal::Notification.create(params:)
- OneSignal::Notification.update(id:, params:)
- OneSignal::Notification.delete(id:, params:)
```

## Changes

See [CHANGELOG.txt](CHANGELOG.txt)

## Contributors

They are [listed here](https://github.com/tbalthazar/onesignal-ruby/graphs/contributors), thanks to them!

## License

Please see [LICENSE](/LICENSE) for licensing details.
