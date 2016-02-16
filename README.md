# OneSignal Ruby bindings

This gem provides a simple SDK to access the [OneSignal API](https://documentation.onesignal.com/docs/server-api-overview).

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

See basic examples in [example.rb](/example.rb)

## Documentation

Specify your API key:

```ruby
OneSignal::OneSignal.api_key = YOUR_API_KEY
```

Then call the following methods on the `App`, `Player` and `Notifications` classes.
The `params` argument is a ruby hash and the accepted/required values are documented in the [OneSignal API documentation](https://documentation.onesignal.com/docs/server-api-overview)

The return value of each method is a `Net::HTTPResponse`.

### Apps

TODO

### Players

```ruby
- OneSignal::Player.all(params:)
- OneSignal::Player.csv_export(app_id:)
- OneSignal::Player.get(id:)
- OneSignal::Player.create(params:)
- OneSignal::Player.create_session(id:, params:)
- OneSignal::Player.create_purchase(id:, params:)
- OneSignal::Player.create_focus(id:, params:)
- OneSignal::Player.update(id:, params:)
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
