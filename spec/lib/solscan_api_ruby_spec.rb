describe SolscanApiRuby do
  it 'has api_url set' do
    expect(described_class::API_URL).to eq("https://public-api.solscan.io")
  end
end
