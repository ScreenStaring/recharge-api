# ReCharge API Client

[![Build Status](https://travis-ci.org/ScreenStaring/recharge-api.svg?branch=master)](https://travis-ci.org/ScreenStaring/recharge-api)

Ruby client for [ReCharge Payments'](https://rechargepayments.com/developers)
recurring payments API for Shopify.

## Installation

Ruby gems:

    gem install recharge-api

Bundler:

    gem "recharge-api", :require => "recharge"

## Usage

An API key is required. The key can be set via `ReCharge.api_key` or via the `RECHARGE_API_KEY`
environment variable.

```rb
require "recharge"

ReCharge.api_key = "YOUR_KEY"  # Can also use Recharge
data = {
  :address_id => 123234321,
  :customer_id => 565728,
  # ... more stuff
  :next_charge_scheduled_at => Time.new,
  :properties => {
    :name => "size",
    :value => "medium"
  }
}

subscription = ReCharge::Subscription.create(data)
subscription.address_id = 454343
subscription.save

# Or
ReCharge::Subscription.update(id, data)

subscription = ReCharge::Subscription.new(data)
subscription.save

order1 = ReCharge::Order.get(123123)
order1.line_items.each do |li|
  p li.title
  p li.quantity
end

order2 = ReCharge::Order.get(453321)
p "Different" if order1 != order2

JSON.dump(order2.to_h)

customers = ReCharge::Customer.list(:page => 10, :limit => 50)
customers.each do |customer|
  addresses = ReCharge::Customer.addresses(customer.id)
  # ...
end
```

For complete documentation refer to the API docs: http://rdoc.info/gems/recharge-api

## Rake Tasks for Webhook Management

Add the following to your `Rakefile`:

```rb
require "recharge/tasks"
```

This will add the following tasks:

  * `recharge:hook:create` - create webhook `HOOK` to be sent to `CALLBACK`
  * `recharge:hooks:delete` - delete the webhook(s) given by `ID`
  * `recharge:hooks:delete_all` - delete all webhooks
  * `recharge:hooks:list` - list webhooks

All tasks require `RECHARGE_API_KEY` be set.

For example, to create a hook run the following:

```
rake recharge:hooks:create RECHARGE_API_KEY=YOURKEY HOOK=subscription/created CALLBACK=https://example.com/callback
```

## License

Released under the MIT License: www.opensource.org/licenses/MIT

---

Made by [ScreenStaring](http://screenstaring.com)
