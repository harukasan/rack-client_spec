require 'power_assert'
require 'rack/client_spec/assertions'
require 'rack/client_spec/expect_request'
require 'rack/client_spec/result'

module Rack
  class ClientSpec
    class TestCase
      include Rack::ClientSpec::Assertions

      def self.make_sequences()
        sequences = {}
        self.instance_methods.grep(/^test_/).map do |name|
          sequences[name] = self.new(nil).call_test_method(name, test: false).sequence
        end
        sequences
      end

      def self.run_sequence(name, sequence)
        r = nil
        begin
          self.new(sequence).call_test_method(name, test: true)
        rescue Assertion => e
          r = e
        end
        Result.new r
      end

      attr_reader :sequence

      def initialize(got_sequence = nil)
        @got_sequence = got_sequence
        @run_test = !got_sequence.nil?
        @sequence = []
      end

      def assert_request(expect_request, &block)
        got = @got_sequence.shift
        unless expect_request.match? got.env
          raise ArgumentError, "Request is not matched with the expected request"
        end
        block.yield got.env, got.response
      end

      def call_test_method(name, test: nil)
        @run_test = test unless test.nil?
        setup if respond_to? :setup
        send name
        self
      end

      def route(method, path, env, &block)
        request = ExpectRequest.new(method, path, env)
        @sequence << request
        assert_request request, &block if @run_test
      end

      def get(path, **env, &block)
        route "GET", path, env, &block
      end
      def head(path, **env, &block)
        route "HEAD", path, env, &block
      end
      def put(path, **env, &block)
        route "PUT", path, env, &block
      end
      def post(path, **env, &block)
        route "POST", path, env, &block
      end
      def delete(path, **env, &block)
        route "DELETE", path, env, &block
      end
      def options(path, **env, &block)
        route "OPTIONS", path, env, &block
      end
      def patch(path, **env, &block)
        route "PATCH", path, env, &block
      end
      def link(path, **env, &block)
        route "LINK", path, env, &block
      end
      def unlink(path, **env, &block)
        route "UNLINK", path, env, &block
      end

      private :get, :head, :put, :post, :delete, :options, :patch, :link, :unlink
    end
  end
end
