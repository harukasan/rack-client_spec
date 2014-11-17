# Rack::ClientSpec

Rack::ClientSpec can test your client.

## TODO

Current implementation is "it just works" for prototyping, not enough for release.

- request flow
- run multiple test methods
- non-existence test
- bug fix

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-client_spec'
```

And then execute:

    $ bundle

## Usage

Write your client spec like below (this code is included in [lib/lobster_spec.rb](https://github.com/harukasan/rack-client_spec/blob/master/lib/lobster_spec.rb)):

```lobster_spec.rb
require 'rack/client_spec'

class LobsterSpec < Rack::ClientSpec::TestCase # <-- test case
  def test_flip_referer # <-- test method
    get '/' do |req, res| # <-- expect request
      assert { res.status == 200 } # <-- assertion
    end

    get '/?flip=left' do |req, res| # <-- expect request
      assert { req['HTTP_REFERER'] == 'http://localhost:9292/' } # <-- assertion
    end

    get '/?flip=right' do |req, res| # <-- expect request
      assert { req['HTTP_REFERER'] == 'http://localhost:9292/?flip=left' }
    end
  end
end
```

Then, use ClientSpec in your config.ru:

```lobster.ru
require 'rack'
require 'rack/lobster'
require 'rack/client_spec'
require 'lobster_spec'

use Rack::ClientSpec, LobsterSpec
run Rack::Lobster.new
```

Finally, rackup your server, and you can test a client (eg. your favorite web browser).

## Contributing

1. [Fork it](https://github.com/harukasan/rack-client_spec/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request.
