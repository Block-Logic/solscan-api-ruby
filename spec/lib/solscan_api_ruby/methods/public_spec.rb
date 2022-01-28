require 'csv'

describe SolscanApiRuby::Methods::Public do

  before(:all) do
    path = File.join(
      'spec',
      'fixtures',
      'expected_responses.json',
    )

    file = File.read(path)
    @expected_responses ||= JSON.parse(file)
  end

  describe "api endpoints" do
    let(:vcr_dir) do |example|
      File.join(
        "lib/solscan_api_ruby/methods/public",
        example.metadata.dig(
          :example_group,
          :parent_example_group,
          :parent_example_group,
          :description
        )
      )
    end

    let(:vcr_file) do |example|
      File.join(vcr_dir, example.description)
    end

    let(:account) { "BbyX1GwUNsfbcoWwnkZDo8sqGmwNDzs2765RpjyQ1pQb" }
    let(:token_address) { "DubwWZNWiNGMMeeQHPnMATNj77YZPZSAz2WVR5WjLJqz" }

    describe "#block_last" do
      context "with no params" do
        context "valid request" do
          it 'returns default 20 records' do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.block_last

              expected_response = @expected_responses['block_last']

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(20)
              expect(response.body.first).to eq(expected_response)
            end
          end
        end
      end

      context "with optional params" do
        context "valid request" do
          it 'returns 5 records' do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.block_last(limit: 5)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(5)
            end
          end
        end

        context "invalid request (limit exceeded)" do
          it "returns 400 error" do
            VCR.use_cassette(vcr_file) do
              expect do
                described_class.new.block_last(limit: 25)
              end.to raise_error(SolscanApiRuby::Client::ApiError) do |error|
                expect(error.status).to eq 400
                expect(error.error).to eq({"message" => "limit parameter must be a number less than 20"})
              end
            end
          end
        end
      end
    end

    describe "#block_transactions" do
      let(:block) { 118086078 }

      context "with required params" do
        context "valid request" do
          it "returns 10 default records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.block_transactions(block)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(10)
            end
          end
        end
      end

      context "with required and optional params" do
        context "valid request" do
          it "returns limited number of records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.block_transactions(block, offset: 2, limit: 5)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(5)
            end
          end
        end
      end
    end

    describe "#block" do
      let(:block) { 118086078 }

      context "with required params" do
        context "valid request" do
          it "returns block info" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.block(block)

              expected_response = @expected_responses['block']

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(expected_response)
            end
          end
        end
      end
    end

    describe "#transaction_last" do
      let(:block) { 118086078 }

      context "with no params" do
        context "valid request" do
          it "returns default 20 last transactions" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.transaction_last

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(20)
            end
          end
        end
      end

      context "with optional params" do
        context "valid request" do
          it "returns specified number of last transactions" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.transaction_last(limit: 5)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(5)
            end
          end
        end
      end
    end

    describe "#transaction" do
      let(:signature) do
        '5vPZJUQFHdwUdHkmBCGaCU65MXzFmDMv218QGNs44RYL3b4wBijtE3fqQZAKuwYz7mCyeLWAcQ5mz99sGTR2a6Ec'
      end

      context "with required param" do
        context "valid request" do
          it "returns detail information of given transaction signature" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.transaction(signature)

              expected_response = @expected_responses['transaction']

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(expected_response)
            end
          end
        end
      end
    end

    describe "#account_tokens" do
      context "with required params" do
        context "valid request" do
          it "gets token balances of the given account" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_tokens(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq([])
            end
          end
        end
      end
    end

    describe "#account_transactions" do
      context "with required params" do
        context "valid request" do
          it "gets list of transactions of the given account (default 10)" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_transactions(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(10)
            end
          end
        end
      end

      context "with required and optional params" do
        let(:limit) { 5 }

        context "valid request" do
          it "gets limited list of transactions of the given account" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_transactions(account, limit: limit)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(5)
            end
          end
        end
      end
    end

    describe "#account_stake_accounts" do
      context "with required params" do
        context "valid request" do
          it "gets staking accounts of the given account" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_stakeAccounts(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body.size).to eq(7)
            end
          end
        end
      end
    end

    describe "#account_splTransfers" do
      context "with required params" do
        context "valid request" do
          it "returns 10 default records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_splTransfers(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body['total']).to eq(0)
            end
          end
        end
      end

      context "with required and optional params" do
        context "valid request" do
          it "returns limited number of records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_splTransfers(
                account,
                from_time: 0,
                to_time: 10,
                offset: 2,
                limit: 5
              )

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body['total']).to eq(-1)
            end
          end
        end
      end
    end

    describe "#account_solTransfers" do
      context "with required params" do
        context "valid request" do
          it "returns 10 default records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_solTransfers(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq({ "data" =>  [] })
            end
          end
        end
      end

      context "with required and optional params" do
        context "valid request" do
          it "returns limited number of records" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_solTransfers(
                account,
                from_time: 0,
                to_time: 10,
                offset: 2,
                limit: 5
              )

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq({ "data" => [] })
            end
          end
        end
      end
    end


    describe "#account_exportTransactions" do
      context "with required params" do
        context "valid request" do
          it "exports transactions to CSV" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account_exportTransactions(
                account,
                type: 'all',
                from_time: 1,
                to_time: 1111111111111
              )

              expected_headers = @expected_responses['export_transactions_headers']

              csv_headers_from_response_body = CSV.parse(
                response.body,
                col_sep: ",",
                row_sep: :auto
              ).flatten
               .map(&:strip)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(csv_headers_from_response_body).to eq(expected_headers)
            end
          end
        end
      end
    end

    describe "#account" do
      context "with required params" do
        context "valid request" do
          it "overall account information, including program account, NFT metadata information" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.account(account)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq({ "account" => "BbyX1GwUNsfbcoWwnkZDo8sqGmwNDzs2765RpjyQ1pQb" })
            end
          end
        end
      end
    end

    describe "#token_holders" do

      context "with required params" do
        context "valid request" do
          it "gets token holders" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.token_holders(token_address)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(@expected_responses['token_holders'])
            end
          end
        end
      end

      context "with required and optional params" do
        context "valid request" do
          it "gets token holders specified by params" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.token_holders(
                token_address,
                offset: 1,
                limit: 3
              )

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body['data'].size).to eq(3)
            end
          end
        end
      end
    end

    describe "#token_meta" do
      context "with required params" do
        context "valid request" do
          it "gets token holders" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.token_meta(token_address)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(@expected_responses['token_meta'])
            end
          end
        end
      end
    end

    describe "#token_list" do
      context "with default (not required) params" do
        context "valid request" do
          it "gets list of 10 (by default) tokens sort by market_cap desc" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.token_list

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body['data'].size).to eq(10)
            end
          end
        end
      end

      context "with optional params" do
        context "valid request" do
          it "gets list of tokens specified by params" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.token_list(
                sort_by: 'volume',
                direction: 'desc',
                limit: 5,
                offset: 2
              )

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body['data'].size).to eq(5)
            end
          end
        end
      end
    end

    describe "#market_token" do
      context "with required params" do
        context "valid request" do
          it "gets market information of the given token" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.market_token(token_address)

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(@expected_responses['market_token'])
            end
          end
        end
      end
    end

    describe "#chaininfo" do
      context "with no params" do
        context "valid request" do
          it "gets blockchain overall information" do
            VCR.use_cassette(vcr_file) do
              response = described_class.new.chaininfo

              expect(response.status).to eq(SolscanApiRuby::Client::HttpCodes::HTTP_OK_CODE)
              expect(response.body).to eq(@expected_responses['chaininfo'])
            end
          end
        end
      end
    end
  end
end
