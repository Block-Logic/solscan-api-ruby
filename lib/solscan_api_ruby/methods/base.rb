module SolscanApiRuby
  module Methods
    class Base
      def initialize(api_client: SolscanApiRuby::Client::FaradayClient)
        @api_client = api_client
      end

      protected
      def create_endpoint_from_method(method)
        method.to_s.split("_").join("/")
      end
    end
  end
end
