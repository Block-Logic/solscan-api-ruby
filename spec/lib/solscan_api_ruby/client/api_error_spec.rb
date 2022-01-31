require 'faraday'
require 'json'
require 'oj'
require 'pry'

class TestClient
  def initialize(conn)
    @conn = conn
  end

  def httpbingo(jname, params: {})
    @conn.get("/#{jname}", params)
  end
end

describe SolscanApiRuby::Client::ApiError do
  let(:stubs)  { Faraday::Adapter::Test::Stubs.new }
  let(:conn)   { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:client) { TestClient.new(conn) }
  let(:faraday_response) { client.httpbingo('ip') }

  before do
    stubs.get('/ip') { [400, content_type, body ] }
  end

  context "response 400" do
    let(:content_type) { { 'Content-Type': 'application/javascript' } }
    let(:status) { { "status" => 400 } }
    let(:error_message) { { "message" => "limit parameter must be a number less than 20" } }

    context "json body" do
      let(:body) { status.merge({"error" => error_message}).to_json }

      it 'returns error and status from body (as solscan provides)' do
        response = described_class.new(faraday_response)

        expect(response.error).to eq(error_message)
        expect(response.status).to eq(400)
      end
    end

    context "not a json body" do
      let(:body) { "Not found." }

      it 'returns not parsed error and status from faraday response' do
        response = described_class.new(faraday_response)

        expect(response.error).to eq(body)
        expect(response.status).to eq(400)
      end
    end
  end
end
