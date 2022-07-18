module SolscanApiRuby
  module Methods
    class Public < Base
      # @see https://public-api.solscan.io/docs/#/Block/get_block_last
      #
      # Get last [limit] blocks
      #
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def block_last(limit: nil)
        params = {}

        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Block/get_block_transactions
      #
      # Get block transactions. MaxLimit 50 records per request
      #
      # @param block [Integer]
      # @param offset [Integer]
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def block_transactions(block, offset: nil, limit: nil)
        params = {}

        params[:block] = block
        params[:offset] = offset if offset
        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Block/get_block__block_
      #
      # Detail information of given block
      #
      # @param block [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def block(block)
        method = "#{__method__}/#{block}"

        send_request(method)
      end

      # @see https://public-api.solscan.io/docs/#/Transaction/get_transaction_last
      #
      # Get last [limit] transactions
      #
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def transaction_last(limit: nil)
        params = {}

        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Transaction/get_transaction__signature_
      #
      # Detail information of given transaction signature
      #
      # @param signature [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def transaction(signature)
        method = "#{__method__}/#{signature}"

        send_request(method)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_tokens
      #
      # Get token balances of the given account
      #
      # @param account [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_tokens(account)
        params = {}

        params[:account] = account if account

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_transactions
      #
      # Get list of transactions of the given account. MaxLimit 50 records per request
      #
      # @param account [String]
      # @param beforeHash [String]
      # @param limit [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_transactions(account, before_hash: '', limit: nil)
        params = {}

        params[:account] = account
        params[:beforeHash] = before_hash if before_hash
        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_stakeAccounts
      #
      # Get staking accounts of the given account
      #
      # @param account [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_stakeAccounts(account)
        params = {}

        params[:account] = account if account

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_splTransfers
      #
      # Get list of transactions make tokenBalance changes. MaxLimit 50 records per request
      #
      # @param account [String]
      # @param fromTime [Integer]
      # @param toTime [Integer]
      # @param offset [Integer]
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_splTransfers(account, from_time: nil, to_time: nil, offset: nil, limit: nil)
        params = {}

        params[:account] = account
        params[:fromTime] = from_time if from_time
        params[:toTime] = to_time if to_time
        params[:offset] = offset if offset
        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_solTransfers
      #
      # Get list of transactions make tokenBalance changes. MaxLimit 50 records per request
      #
      # @param account [String]
      # @param fromTime [Integer]
      # @param toTime [Integer]
      # @param offset [Integer]
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_solTransfers(account, from_time: nil, to_time: nil, offset: nil, limit: nil)
        params = {}

        params[:account] = account
        params[:fromTime] = from_time if from_time
        params[:toTime] = to_time if to_time
        params[:offset] = offset if offset
        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account_exportTransactions
      #
      # Export transactions to CSV. MaxLimit 5000 records per request
      #
      # @param account [String]
      # @param type [String] Allowed types: tokenchange | soltransfer | all
      # @param fromTime [Integer]
      # @param toTime [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account_exportTransactions(account, type:, from_time:, to_time:)
        params = {}

        params[:account] = account
        params[:type] = type
        params[:fromTime] = from_time
        params[:toTime] = to_time

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Account/get_account__account_
      #
      # Get overall account information, including program account, NFT metadata information
      #
      # @param account [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def account(account)
        method = "#{__method__}/#{account}"

        send_request(method)
      end


      # @see https://public-api.solscan.io/docs/#/Token/get_token_holders
      #
      # Get token holders
      #
      # @param token_address [String]
      # @param offset [Integer]
      # @param limit [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def token_holders(token_address, offset: nil, limit: nil)
        params = {}

        params[:tokenAddress] = token_address
        params[:offset] = offset if offset
        params[:limit] = limit if limit

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Token/get_token_meta
      #
      # Get metadata of given token.
      #
      # @param token_address [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def token_meta(token_address)
        params = {}

        params[:tokenAddress] = token_address

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Token/get_token_list
      #
      # Get list of tokens. MaxLimit 50 records per request.
      #
      # @param sort_by [String] Available values : market_cap, volume, holder,
      #                                            price, price_change_24h, price_change_7d,
      #                                            price_change_14d, price_change_30d,
      #                                            price_change_60d, price_change_200d,
      #                                            price_change_1y
      #
      # @param direction [String] desc or asc, default desc
      # @param limit [Integer]
      # @param offset [Integer]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def token_list(sort_by: 'market_cap', direction: 'desc', limit: nil, offset: nil)
        params = {}

        params[:sortBy] = sort_by if sort_by
        params[:direction] = direction if direction
        params[:limit] = limit if limit
        params[:offset] = offset if offset

        send_request(__method__, params: params)
      end

      # @see https://public-api.solscan.io/docs/#/Market/get_market_token__tokenAddress_
      #
      # Get market information of the given token
      #
      # @param token_address [String]
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def market_token(token_address)
        method = "#{__method__}/#{token_address}"

        send_request(method)
      end

      # @see https://public-api.solscan.io/docs/#/Chain%20Information/get_chaininfo_
      #
      # Blockchain overall information
      #
      # @return [Response, ApiError] Response when success, ApiError on failure.
      def chaininfo
        send_request(__method__)
      end

      private

      def send_request(method, http_method: :get, params: {})
        endpoint = create_endpoint_from_method(method)

        @api_client.new.call_api(
          endpoint: endpoint,
          http_method: http_method,
          params: params
        )
      end
    end
  end
end
