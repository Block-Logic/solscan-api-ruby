require 'oj'

module SolscanApiRuby
  module Client
    ##
    # ApiError is a wrapper class for errors.
    #
    class ApiError < StandardError
      # Error code.
      # @return [Integer]
      attr_reader :status

      # Error message.
      # @return [Hash]
      attr_reader :error

      # Initialize object with json response from the API with error.
      #
      # @param api_response [Object]
      #
      # @return [SolscanApiRuby::Client::ApiError]
      def initialize(api_response)
        body = Oj.load(api_response.body)

        @error = body['error']
        @status = body['status']
      rescue Oj::ParseError
        @error = api_response.body
        @status = api_response.status
      end
    end
  end
end
