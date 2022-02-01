require_relative 'lib/solscan_api_ruby'

res = SolscanApiRuby::Methods::Public.new.chaininfo

puts "Success?"
puts res.successfull?
puts "\n"
puts "Status:"
puts res.status
puts "\n"
puts "Headers:"
puts res.headers
puts "\n"
puts "Body:"
puts res.body

