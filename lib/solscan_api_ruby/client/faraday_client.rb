require 'faraday'
require 'faraday/net_http'
require 'oj'
require 'pry'

require_relative "http_codes"
require_relative "api_error"

module SolscanApiRuby

  module Client
    class FaradayClient < Base
      include SolscanApiRuby::Client::HttpCodes

      Faraday.default_adapter = :net_http

      def call_api(endpoint:, http_method:, params: {})
        endpoint_url = create_endpoint_url(endpoint)

        api_response = client.public_send(http_method, endpoint_url, params)
        if api_response.status == HTTP_OK_CODE
          Response.new(api_response)
        else
          fail ApiError.new(api_response)
        end
      end

      private

      def client
        Faraday.new(@api_url) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
        end
      end
    end
  end
end

