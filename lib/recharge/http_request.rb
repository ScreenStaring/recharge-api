require "net/http"
require "uri"
require "json"

# For iso8601
require "date"
require "time"

module Recharge
  module HTTPRequest # :nodoc:

    protected

    def DELETE(path, data = {})
      request(Net::HTTP::Delete.new(path), data)
    end

    def GET(path, data = {})
      path += sprintf("?%s", URI.encode_www_form(data)) if data && data.any?
      request(Net::HTTP::Get.new(path))
    end

    def POST(path, data = {})
      request(Net::HTTP::Post.new(path), data)
    end

    def PUT(path, data = {})
      request(Net::HTTP::Put.new(path), data)
    end

    def id_required!(id)
      raise ArgumentError, "id required" if id.nil? || id.to_s.strip.empty?
    end

    def join(*parts)
      parts.unshift(self::PATH).join("/")
    end

    def convert_date_params(options, *keys)
      return unless options

      options = options.dup
      keys.each do |key|
        options[key] = date_param(options[key]) if options.include?(key)
      end

      options
    end

    def date_param(date)
      # ReCharge doesn't accept 8601, 500s on zone specifier
      # date.respond_to?(:iso8601) ? date.iso8601 : date
      date.respond_to?(:strftime) ? date.strftime("%Y-%m-%dT%H:%M:%S") : date
    end

    private

    def request(req, data = {})
      req[TOKEN_HEADER] = ReCharge.api_key || ENV["RECHARGE_API_KEY"] || ""
      req["User-Agent"] = USER_AGENT

      if req.request_body_permitted? && data && data.any?
        req.body = data.to_json
        req["Content-Type"] = "application/json"
      end

      connection.start do |http|
        res = http.request(req)
        data = res["Content-Type"] == "application/json" ? parse_json(res.body) : {}
        data["meta"] = { "id" => res["X-Request-Id"], "limit" => res["X-Recharge-Limit"] }

        return data if res.code[0] == "2" && !data["warning"] && !data["error"]

        message = data["warning"] || data["error"] || "#{res.code} - #{res.message}"
        raise RequestError.new(message, res.code, data["meta"], data["errors"])
      end
    rescue Net::ReadTimeout, IOError, SocketError, SystemCallError => e
      raise ConnectionError, "connection failure: #{e}"
    end

    def connection
      unless defined? @request
        @request = Net::HTTP.new(ENDPOINT, PORT)
        @request.use_ssl = true
      end

      if !Recharge.debug
        @request.set_debug_output(nil)
      else
        @request.set_debug_output(
          Recharge.debug.is_a?(IO) ? Recharge.debug : $stderr
        )
      end

      @request
    end

    def parse_json(s)
      JSON.parse(s)
    rescue JSON::ParserError => e
      raise Error, "failed to parse JSON response: #{e}"
    end

    #
    # Make a count request to the included/extended class' endpoint
    #
    # === Arguments
    #
    # [options (Hash)] Optional arguments to filter the count on.
    #
    # See the appropriate count call in {ReCharge's documentation}[https://developer.rechargepayments.com/] for valid options.
    #
    # === Returns
    #
    # +Fixnum+ of the resulting count
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    module Count
      include HTTPRequest

      def count(options = nil)
        GET(join("count"), options)["count"]
      end
    end

    #
    # Create an new record for the included/extended entity
    #
    # === Arguments
    #
    # [data (Hash)] New record's attributes
    #
    # See the appropriate create call in {ReCharge's documentation}[https://developer.rechargepayments.com/] for valid attributes
    #
    # === Returns
    #
    # An instance of the created entity
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    module Create
      include HTTPRequest

      def create(data)
        new(POST(self::PATH, data)[self::SINGLE])
      end
    end

    #
    # Delete a record for included/extended entity
    #
    # === Arguments
    #
    # [id (Fixnum)] ID of the record to delete
    #
    # === Returns
    #
    # An instance of the deleted entity
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    module Delete
      include HTTPRequest

      def delete(id)
        id_required!(id)
        DELETE(join(id))
      end
    end

    module Get
      include HTTPRequest

      def get(id)
        id_required!(id)
        new(GET(join(id))[self::SINGLE])
      end
    end

    #
    # Retrieve a page of records for the included/extended class' endpoint
    #
    # === Arguments
    #
    # [options (Hash)] Optional arguments to filter the result set on.
    #
    # In most cases +:page+ and +:limit+ are accepted but see
    # the appropriate call in {ReCharge's documentation}[https://developer.rechargepayments.com/] for valid options.
    #
    # === Returns
    #
    # +Array+ of record instances
    #
    # === Errors
    #
    # Recharge::ConnectionError, Recharge::RequestError
    #
    module List
      include HTTPRequest

      def list(options = nil)
        data = GET(self::PATH, options)
        (data[self::COLLECTION] || []).map { |d| new(d.merge("meta" => data["meta"])) }
      end
    end

    module Update
      include HTTPRequest

      def update(id, data)
        id_required!(id)
        new(PUT(join(id), data)[self::SINGLE])
      end
    end
  end
end
