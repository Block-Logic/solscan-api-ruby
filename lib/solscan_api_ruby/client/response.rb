require 'oj'
require_relative 'http_codes'

module SolscanApiRuby
  module Client
    ##
    # Response class parses response from the API to the more convenient format.
    #
    class Response
      include HttpCodes

      # Initialize object with response body in json format.
      #
      # @param response [Hash] hash with response from the API.
      def initialize(response)
        @response = response
      end

      # @return [Hash] parsed response body.
      def body
        @body ||= Oj.load(@response.body)
      end

      # @return [Hash] response headers.
      def headers
        @response.headers
      end

      # @return [Integer] response status.
      def status
        @response.status
      end

      # @return [Boolean] response success.
      def successfull?
        status == HTTP_OK_CODE
      end
    end
  end
end
