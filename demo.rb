require_relative 'lib/solscan_api_ruby'

res = SolscanApiRuby::Methods::Public.new.chaininfo

puts res.status
puts "\n"
puts res.headers
puts "\n"
puts res.body

