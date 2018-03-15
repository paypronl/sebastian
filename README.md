# Sebastian

[![Version](https://badge.fury.io/rb/sebastian.svg)](https://rubygems.org/gems/sebastian)
[![circleci](https://circleci.com/gh/paypronl/sebastian/tree/master.svg?style=shield&circle-token=2bde3711c161ef65a75da7a41385d5958253d05b)](https://circleci.com/gh/paypronl/sebastian)

Sebastian makes it easy for you to have service objects in Ruby. It gives you a place to put your business logic.
It also helps you write safer code by validating that your inputs conform to your expectations.


## Installation

Add this line to your Gemfile:

```ruby
gem 'sebastian'
```

Or install it manually:
```
$ gem install sebastian
```
## Usage

To define a service object, create a subclass of Sebastian::Base. Then you need to do two things:

1. **Define your attributes.**
2. **Define your business logic.** Do this by implementing the #execute method. Each attribute you defined will be available. If any of the attributes are invalid, `#execute` won't be run.

That covers the basics. Let's put it all together into a simple example that squares a number.

```ruby
class CreatePayment < Sebastian::Base
  attr_accessor :amount
  attr_accessor :email

  validates :amount, numericality: { only_integer: true }

  private

  def execute
    'payment_created' if create_payment
    errors.add(:payment)
  end

  def create_payment
    Payment.create!(customer: create_customer, amount: amount)
  end

  def create_customer
    Customer.create!(email: email)
  end
end
```

Call `.perform` on your service to execute it. You must pass a single hash to `.perform`. It will return an instance of your service. By convention, we call this an result. You can use the `#ok?` method to ask the result if it's ok. If it's not ok, take a look at its errors with `#errors`. When `#ok?`, the value returned from `#execute` will be stored in `#value`.

```ruby
result = CreatePayment.perform(email: 'ciel@phantomhive.com', amount: 500)
result.ok?
# => true
result.value
# => "payment_created"

result = CreatePayment.perform(amount: 500)
result.ok?
# => false
result.errors.messages
# => {:payment=>["is not a valid"]}
result.value
# => Sebastian::ResultHasErrorsError: Cannot call value while the service has errors, you should call #ok? first to check
```

### Validations

These validations aren't provided by Sebastian. They're from ActiveModel. You can also use any custom validations you wrote yourself in your services.

```ruby
result = CreatePayment.perform(email: 'ciel@phantomhive.com', amount: '5,00')
result.ok?
# => false
result.errors.messages
# => {:amount=>["is not a number"]}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paypronl/sebastian.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
