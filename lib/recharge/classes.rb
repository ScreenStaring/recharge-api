# frozen_string_literal: true

require "json"
require "class2"
require "recharge/http_request"

class2 "Recharge", JSON.parse(<<-END) do
{
  "subscription":
     {
        "id":10101,
        "address_id":178918,
        "analytics_data": {},
        "customer_id":1438,
        "cancellation_reason": "$$$$",
        "cancellation_reason_comments": "",
        "cancelled_at":"2017-02-28T20:31:29",
        "charge_interval_frequency": "3",
        "created_at":"2017-02-28T20:31:29",
        "updated_at":"2017-02-28 20:31:29",
        "next_charge_scheduled_at":"2017-04-01T00:00:00",
        "cancelled_at":null,
        "has_queued_charges": 1,
        "is_skippable": true,
        "is_swappable": true,
        "is_prepaid": false,
        "max_retries_reached": 0,
        "product_title":"Sumatra Coffee",
        "price":12.0,
        "quantity":1,
        "recharge_product_id": 518676,
        "status":"ACTIVE",
        "shopify_product_id":1255183683,
        "shopify_variant_id":3844924611,
        "sku_override": false,
        "sku":null,
        "order_interval_unit":"day",
        "order_interval_frequency":"30",
        "charge_interval_frequency":"30",
        "order_day_of_month":null,
        "order_day_of_week":null,
        "properties": [],
        "variant_title": "Milk - a / b"
     },
  "charge":
    {
      "address_id":178918,
      "analytics_data": {},
      "billing_address":{
         "address1":"3030 Nebraska Avenue",
         "address2":"",
         "city":"Los Angeles",
         "company":"",
         "country":"United States",
         "first_name":"Mike",
         "last_name":"Flynn",
         "phone":"",
         "province":"California",
         "zip":"90404"
      },
      "client_details": {
        "browser_ip": null,
        "user_agent": null
      },
      "created_at":"2017-03-01T19:52:11",
      "customer_hash":null,
      "customer_id":10101,
      "first_name":"Mike",
      "has_uncommited_changes": false,
      "id":1843,
      "last_name":"Flynn",
      "line_items":[
         {
            "grams":0,
            "images": {},
            "price":100.0,
            "properties":[],
            "quantity":1,
            "shopify_product_id": "1255183683",
            "shopify_variant_id":"3844924611",
            "sku":"",
            "title": "Milk  10% Off Auto renew",
            "variant_title": "a / b",
            "vendor": "Example Storeeeeeee",
            "subscription_id":14562
         }
      ],
      "note": "blah blah",
      "note_attributes": [],
      "processor_name": "foo",
      "processed_at":"2014-11-20T00:00:00",
      "scheduled_at":"2014-11-20T00:00:01",
      "shipments_count":null,
      "shipping_address":{
         "address1":"3030 Nebraska Avenue",
         "address2":"",
         "city":"Los Angeles",
         "company":"",
         "country":"United States",
         "first_name":"Mike",
         "last_name":"Flynn",
         "phone":"3103843698",
         "province":"California",
         "zip":"90404"
      },
      "shipping_lines": [],
      "shopify_order_id":"281223307",
      "status":"SUCCESS",
      "total_price":446.00,
      "updated_at":"2016-09-05T09:19:29",
      "tax_lines": 0,
      "total_discounts": "0.0",
      "total_line_items_price": "12.00",
      "total_price": "12.00",
      "total_refunds": null,
      "total_tax": 0,
      "total_weight": 4536,
      "transaction_id": "cch_1Du2QpJ2iqHvZRd18RyqoPvc",
      "type": "RECURRING"
    },
  "customer":
     {
        "id": 1438,
        "hash": "143806234a9ff87a8d9e",
        "shopify_customer_id": null,
        "email": "mike@gmail.com",
        "created_at": "2018-01-10T11:00:00",
        "updated_at": "2017-01-11T13:16:19",
        "first_name": "Mike",
        "last_name": "Flynn",
        "billing_first_name": "Mike",
        "billing_last_name": "Flynn",
        "billing_company": null,
        "billing_address1": "3030 Nebraska Avenue",
        "billing_address2": null,
        "billing_zip": "90404",
        "billing_city": "Los Angeles",
        "billing_province": "California",
        "billing_country": "United States",
        "billing_phone": "3103843698",
        "processor_type": null,
        "status": "FOO",
        "stripe_customer_token": "123123",
        "paypal_customer_token": "123123",
        "braintree_customer_token": "123123"
    },
  "order": {
     "id":7271806,
     "customer_id":10101,
     "address_id":178918,
     "charge_id":9519316,
     "transaction_id":"ch_19sdP2J2zqHvZRd1hqkeGANO",
     "shopify_order_id":"5180645510",
     "shopify_order_number":5913,
     "created_at":"2017-03-01T14:46:26",
     "updated_at":"2017-03-01T14:46:26",
     "scheduled_at":"2017-03-01T00:00:00",
     "processed_at":"2017-03-01T14:46:26",
     "status":"SUCCESS",
     "charge_status":"SUCCESS",
     "type":"CHECKOUT",
     "first_name":"Mike",
     "last_name":"Flynn",
     "email":"mike@gmail.com",
     "payment_processor":"stripe",
     "address_is_active":1,
     "is_prepaid":false,
     "line_items":[
        {
           "subscription_id":10101,
           "shopify_product_id":"1255183683",
           "shopify_variant_id":"3844924611",
           "variant_title":"Sumatra",
           "title":"Sumatra Latte",
           "quantity":1,
           "properties":[]
        }
     ],
     "total_price":18.00,
     "shipping_address":{
        "address1":"1933 Manning",
        "address2":"204",
        "city":"los angeles",
        "province":"California",
        "first_name":"mike",
        "last_name":"flynn",
        "zip":"90025",
        "company":"bootstrap",
        "phone":"3103103101",
        "country":"United States"
     },
     "billing_address":{
        "address1":"1933 Manning",
        "address2":"204",
        "city":"los angeles",
        "province":"California",
        "first_name":"mike",
        "last_name":"flynn",
        "zip":"90025",
        "company":"bootstrap",
        "phone":"3103103101",
        "country":"United States"
     }
  },
  "metafield": {
    "created_at": "2018-11-05T12:59:30",
    "description": "desc lorem ipsum",
    "id": 15,
    "key": "marjan",
    "namespace": "nmsp2c",
    "owner_id": 17868054,
    "owner_resource": "customer",
    "updated_at": "2018-11-05T15:48:42",
    "value": "5",
    "value_type": "integer"
  },
  "product": {
    "collection_id": null,
    "created_at": "2019-11-07T11:36:19",
    "discount_amount": 15.0,
    "discount_type": "percentage",
    "handle": null,
    "id": 1327844,
    "images": {},
    "product_id": 4354268856408,
    "shopify_product_id": 4354268856408,
    "subscription_defaults": {
      "charge_interval_frequency": 4,
      "cutoff_day_of_month": null,
      "cutoff_day_of_week": null,
      "expire_after_specific_number_of_charges": null,
      "modifiable_properties": [],
      "number_charges_until_expiration": null,
      "order_day_of_month": 0,
      "order_day_of_week": null,
      "order_interval_frequency": 4,
      "order_interval_frequency_options": [],
      "order_interval_unit": "month",
      "storefront_purchase_options": "subscription_only"
    },
    "title": "T-shirt",
    "updated_at": "2019-11-07T14:04:52"
  },
  "webhook": {
     "id":6,
     "address":"https://request.in/foo",
     "topic":"order/create"
  },
  "address":{
    "id":3411137,
    "address1":"1933 Manning",
    "address2":"204",
    "city":"los angeles",
    "province":"California",
    "first_name":"mike",
    "last_name":"flynn",
    "zip":"90025",
    "company":"bootstrap",
    "phone":"3103103101",
    "country":"United States"
  },
  "discount":{
    "id": 3748296,
    "code": "Discount1",
    "value": 12.5,
    "ends_at": "2019-12-15T00:00:00",
    "starts_at": "2018-05-16T00:00:00",
    "status": "enabled",
    "usage_limit": 10,
    "applies_to_id": null,
    "discount_type": "percentage",
    "applies_to": null,
    "applies_to_resource": null,
    "times_used": 0,
    "duration": "usage_limit",
    "duration_usage_limit": 10,
    "applies_to_product_type": "ALL",
    "created_at": "2018-04-25T14:32:39",
    "updated_at": "2018-05-04T13:33:53",
    "once_per_customer": false
  }
}
END
  def meta=(meta)
    @meta = meta
  end

  def meta
    @meta ||= {}
  end

  private

  def self.instance(response)
    args = response[self::SINGLE]
    args["meta"] = response["meta"]
    new(args)
  end
end

module Recharge
  module Persistable  # :nodoc:
    def save
      data = to_h
      data.delete("id")

      if id
        self.class.update(id, data)
      else
        self.id = self.class.create(data).id
      end
    end
  end

  class Address
    PATH = "/addresses".freeze
    SINGLE = "address".freeze
    COLLECTION = "addresses".freeze

    extend HTTPRequest::Get
    extend HTTPRequest::Update

    #
    # Persist the updated address
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    def save
      data = to_h
      data.delete("id")
      self.class.update(id, data)
    end

    # Validate an address
    #
    # === Arguments
    #
    # [data (Hash)] Address to validate, see: https://developer.rechargepayments.com/?shell#validate-address
    #
    # === Returns
    #
    # [Hash] Validated and sometimes updated address
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    # If the address is invalid a Recharge::RequestError is raised. The validation
    # errors can be retrieved via Recharge::RequestError#errors
    #
    def self.validate(data)
      POST(join("validate"), data)
    end
  end

  class Customer
    PATH = "/customers".freeze
    SINGLE = "customer".freeze
    COLLECTION = "customers".freeze

    extend HTTPRequest::Create
    extend HTTPRequest::Get
    extend HTTPRequest::Update
    extend HTTPRequest::List
    extend HTTPRequest::Count

    include Persistable

    # Retrieve all of a customer's addresses
    #
    # === Arguments
    #
    # [id (Fixnum)] Customer ID
    #
    # === Errors
    #
    # ConnectionError, RequestError
    #
    # === Returns
    #
    # [Array[Recharge::Address]] The customer's addresses
    #
    def self.addresses(id)
      id_required!(id)
      data = GET(join(id, Address::COLLECTION))
      (data[Address::COLLECTION] || []).map do |d|
        address = Address.new(d)
        address.meta = data["meta"]
        address
      end
    end

    # Create a new address
    #
    # === Arguments
    #
    # [id (Fixnum)] Customer ID
    # [address (Hash)] Address attributes, see: https://developer.rechargepayments.com/?shell#create-address
    #
    # === Returns
    #
    # [Recharge::Address] The created address
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    def self.create_address(id, address)
      id_required!(id)
      data = POST(join(id, Address::COLLECTION), address)
      address = Address.new(data[Address::SINGLE])
      address.meta = data["meta"]
      address
    end
  end

  class Charge
    PATH = "/charges".freeze
    SINGLE = "charge".freeze
    COLLECTION = "charges".freeze

    extend HTTPRequest::Count
    extend HTTPRequest::Get
    extend HTTPRequest::List

    def self.list(options = nil)
      super(convert_date_params(options, :date_min, :date_max))
    end

    def self.change_next_charge_date(id, date)
      path = join(id, "change_next_charge_date")
      instance(POST(path, :next_charge_date => date_param(date)))
    end

    def self.skip(id, subscription_id)
      path = join(id, "skip")
      instance(POST(path, :subscription_id => subscription_id))
    end
  end

  class Discount
    PATH = "/discounts".freeze
    SINGLE = "discount".freeze
    COLLECTION = "discounts"

    extend HTTPRequest::Count
    extend HTTPRequest::Create
    extend HTTPRequest::Delete
    extend HTTPRequest::Get
    extend HTTPRequest::List
    extend HTTPRequest::Update

    include Persistable

    def self.count(options = nil)
      super(convert_date_params(options, :created_at_max, :created_at_min, :date_min, :date_max))
    end

    def self.list(options = nil)
      super(convert_date_params(options, :created_at, :created_at_max, :updated_at, :updated_at_max))
    end

    def delete
      self.class.delete(id)
      true
    end
  end

  class Metafield
    PATH = "/metafields"
    SINGLE = "metafield"
    COLLECTION = "metafields"

    extend HTTPRequest::Count
    extend HTTPRequest::Create
    extend HTTPRequest::Delete
    extend HTTPRequest::Get
    extend HTTPRequest::List

    include Persistable

    def self.list(owner, options = nil)
      raise ArgumentError, "owner resource required" if owner.nil? || owner.to_s.strip.empty?
      super (options||{}).merge(:owner_resource => owner)
    end

    def delete
      self.class.delete(id)
      true
    end
  end

  class Order
    PATH = "/orders".freeze
    SINGLE = "order".freeze
    COLLECTION = "orders".freeze

    extend HTTPRequest::Count
    extend HTTPRequest::Get
    extend HTTPRequest::List

    def self.count(options = nil)
      super(convert_date_params(options, :created_at_max, :created_at_min, :date_min, :date_max))
    end

    def self.change_date(id, date)
      id_required!(id)
      instance(POST(join(id, "change_date"), :shipping_date => date_param(date)))
    end

    def self.update_shopify_variant(id, old_variant_id, new_varient_id)
      id_required!(id)
      path = join(id, "update_shopify_variant", old_variant_id)
      instance(POST(path, :new_shopify_variant_id => new_varient_id))
    end
  end

  class Product
    PATH = "/products".freeze
    SINGLE = "product".freeze
    COLLECTION = "products".freeze

    extend HTTPRequest::Count
    extend HTTPRequest::Get
    extend HTTPRequest::List
  end

  class Subscription
    PATH = "/subscriptions".freeze
    SINGLE = "subscription".freeze
    COLLECTION = "subscriptions".freeze

    extend HTTPRequest::Create
    extend HTTPRequest::Get
    extend HTTPRequest::Update
    extend HTTPRequest::List

    include Persistable

    #
    # Activate a subscription
    #
    # === Arguments
    #
    # [id (Integer)] ID of subscription to cancel
    #
    # === Returns
    #
    # [Recharge::Subscription] The activated subscription
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    # If the subscription was already activated a Recharge::RequestError will be raised
    #
    def self.activate(id)
      id_required!(id)
      instance(POST(join(id, "activate"), :status => "active"))
    end

    #
    # Cancel a subscription
    #
    # === Arguments
    #
    # [id (Integer)] ID of subscription to cancel
    # [reason (String)] Reason for the cancellation
    #
    # === Returns
    #
    # [Recharge::Subscription] The canceled subscription
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    # If the subscription was already canceled a Recharge::RequestError will be raised
    #
    def self.cancel(id, reason)
      id_required!(id)
      instance(POST(join(id, "cancel"), :cancellation_reason => reason))
    end

    def self.set_next_charge_date(id, date)
      id_required!(id)
      instance(POST(join(id, "set_next_charge_date"), :date => date_param(date)))
    end

    def self.list(options = nil)
      #options[:status] = options[:status].upcase if options[:status]
      super(convert_date_params(options, :created_at, :created_at_max, :updated_at, :updated_at_max))
    end
  end

  class Webhook
    PATH = "/webhooks".freeze
    COLLECTION = "webhooks".freeze
    SINGLE = "webhook".freeze

    extend HTTPRequest::Create
    extend HTTPRequest::Delete
    extend HTTPRequest::Get
    extend HTTPRequest::List
    extend HTTPRequest::Update

    include Persistable

    def delete
      self.class.delete(id)
      true
    end
  end
end
