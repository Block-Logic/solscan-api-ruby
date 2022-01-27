module SolscanApiRuby
  module Client
    class Base
      attr_accessor :api_url

      def initialize(api_url: SolscanApiRuby.api_url)
        @api_url = api_url
      end

      def call_api
        raise 'Method call_api needs to be implemented in child class'
      end

      protected
      def create_endpoint_url(endpoint)
        "#{@api_url}/#{endpoint}"
      end
    end
  end
end
