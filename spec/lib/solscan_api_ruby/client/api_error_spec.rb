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

  context "response 400" do
    before do
      stubs.get('/ip') do
        [
          400,
          { 'Content-Type': 'application/javascript' },
          '{"status":400,"error":{"message":"limit parameter must be a number less than 20"}}'
        ]
      end
    end

    it 'returns original body without parsing when body is not a valid JSON' do
      response = described_class.new(faraday_response)

      expect(response.body).to eq('Not found')
      expect(response.headers).to eq("Content-type" => "application/javascript")
      expect(response.status).to eq(400)
      expect(response.successfull?).to be_falsey
    end
  end
end
