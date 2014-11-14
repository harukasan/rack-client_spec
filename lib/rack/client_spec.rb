require 'rack/client_spec/version'
require 'rack/client_spec/test_case'
require 'rack/client_spec/request_trace'
require 'rack/client_spec/got_request'
require 'rack/client_spec/printer'

module Rack
  class ClientSpec
    def initialize(app, test_case)
      @app = app
      @test_case = test_case
      @tracer = RequestTrace.new(test_case.make_sequences)
      @sequence = []
      Printer.print_initialized
      Printer.print_states @tracer.states
    end

    def call(env)
      response = @app.call(env)
      begin
        do_test(env, response)
      rescue => e
        p e
      end
      return response
    end

    def do_test(env, response)
      @sequence << GotRequest.new(env, response)
      matched = @tracer.trace(env)
      if matched
        match_function = @tracer.match

        result = @test_case.run_sequence(match_function, @sequence)
        @tracer.reset(match_function)
      end

      Printer.print_states @tracer.states
      if result
        if result.success?
          Printer.print_success match_function
        else
          Printer.print_fail match_function, result
        end
      end
    end

  end
end
