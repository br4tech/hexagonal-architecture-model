# AllowNumeric

This gem provides easy way to restrict numeric input to input fields using jquery and integrates with Rails asset pipeline for easy of use.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'allow_numeric'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install allow_numeric

## Usage

### Add following line to "app/assets/javascripts/application.js"
```
//= require allow_numeric
```
and restart rails server.

## Add ```data-numeric="true"``` to field for which you want to allow numeric input only.

##### For example:

---
```
<%= form_for @person do |f| %>
  ..
  ..
  <%= f.label :phone %>:
  <%= f.text_field :phone, data: { numeric: true } %><br />

  <%= f.submit %>
<% end %>
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/allow_numeric. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AllowNumeric project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/allow_numeric/blob/master/CODE_OF_CONDUCT.md).
