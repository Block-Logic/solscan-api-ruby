# frozen_string_literal: true

# /client
require_relative "solscan_api_ruby/client/base"
require_relative "solscan_api_ruby/client/faraday_client"
require_relative "solscan_api_ruby/client/response"
require_relative "solscan_api_ruby/client/http_codes"

# /methods
require_relative "solscan_api_ruby/methods/base"
require_relative "solscan_api_ruby/methods/public"

module SolscanApiRuby
  class << self
    # Api url.
    # @return [String] api url.
    def api_url
      "https://public-api.solscan.io"
    end
  end
end
