require 'faraday'
require 'json'
require 'oj'
require 'pry'

class Client
  def initialize(conn)
    @conn = conn
  end

  def httpbingo(jname, params: {})
    @conn.get("/#{jname}", params)
  end
end

describe SolscanApiRuby::Client::Response do
  let(:stubs)  { Faraday::Adapter::Test::Stubs.new }
  let(:conn)   { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:client) { Client.new(conn) }
  let(:faraday_response) { client.httpbingo('ip') }
  let(:content_type) { { "Content-type" => "application/javascript" } }

  before do
    stubs.get('/ip') { [status, content_type, body] }
  end

  context "response 200" do
    context "valid json body" do
      let(:body) { '{"origin": "127.0.0.1"}' }
      let(:status) { 200 }

      it 'correctly parses faraday response body' do
        response = described_class.new(faraday_response)

        expect(response.body).to eq({ "origin" => "127.0.0.1" })
        expect(response.headers).to eq(content_type)
        expect(response.status).to eq(200)
        expect(response.successfull?).to be_truthy
      end
    end
  end

  context 'response 404' do
    context 'body is not a valid json' do
      let(:body) { 'Not found' }
      let(:status) { 404 }

      it 'returns original body without parsing when body is not a valid JSON' do
        faraday_response = client.httpbingo('ip')
        response = described_class.new(faraday_response)

        expect(response.body).to eq(body)
        expect(response.headers).to eq(content_type)
        expect(response.status).to eq(404)
        expect(response.successfull?).to be_falsey
      end
    end
  end
end
