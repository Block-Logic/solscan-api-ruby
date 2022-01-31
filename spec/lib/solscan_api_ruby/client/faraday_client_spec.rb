require 'webmock/rspec'
require 'json'

describe SolscanApiRuby::Client::FaradayClient do
  let(:vcr_dir) { "lib/solscan_api_ruby/client/" }

  describe "#initialize" do
    it "has api_url set" do
      expect(described_class.new.api_url).to eq("https://public-api.solscan.io")
    end
  end

  describe "#call_api" do
    let(:endpoint) { "block/last" }
    let(:http_method) { :get }
    let(:api_endpoint) { "https://public-api.solscan.io/block/last" }

    before do
      stub_request(:get, api_endpoint).to_return(body: body.to_json, status: response_status)
    end

    context "when request is successful" do
      let(:params) { { limit: -1 } }
      let(:body) { { "message" => "Correct" , "status" => 200 } }
      let(:response_status) { 200 }

      it "returns instance of Response class" do
        response = described_class.new.call_api(
          endpoint: endpoint,
          http_method: http_method
        )

        expect(response.class).to eq(SolscanApiRuby::Client::Response)
        expect(response.status).to eq(200)
        expect(response.body).to eq(body)
      end
    end

    context "when request fails" do
      let(:params) { { limit: -1 } }
      let(:body) { { "error" => { "message" => "Error" }, "status" => 400 } }
      let(:response_status) { 400 }

      it "raises ApiError and returns instance of ApiError class" do
        expect do
          described_class.new.call_api(
            endpoint: "block/last",
            http_method: http_method
          )
        end.to raise_error(SolscanApiRuby::Client::ApiError) do |response|
          expect(response.status).to eq 400
          expect(response.error).to eq(body['error'])
        end
      end
    end
  end
end
