

![specs](https://github.com/Block-Logic/solscan-api-ruby/actions/workflows/specs.yml/badge.svg)
![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)
![Last Commit](https://img.shields.io/github/last-commit/Block-Logic/solscan-api-ruby)
![Tag](https://img.shields.io/github/v/tag/Block-Logic/solscan-api-ruby)
![Stars](https://img.shields.io/github/stars/Block-Logic/solscan-api-ruby.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
# solscan-api-ruby
Ruby Client for the Solscan API. This gem provides a wrapper methods for Solscan API https://public-api.solscan.io/docs

## Getting started

### Requirements

This gem requires Ruby 2.6+ and h Rails 6.0+. It MIGHT work with lower versions, but was not tested with them.
Add the following line to your Gemfile:

```ruby
gem 'solscan_api_ruby'
```

Then run `bundle install`

### Usage examples

#### JSON RPC API
```ruby
# If you set default cluster you don't need to pass it every time.
method_wrapper = SolscanApiRuby::Methods.new

response = method_wrapper.block_last
puts response
```
