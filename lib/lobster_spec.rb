require 'rack/client_spec'

class LobsterSpec < Rack::ClientSpec::TestCase # <-- test case
  def test_flip # <-- test method
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

