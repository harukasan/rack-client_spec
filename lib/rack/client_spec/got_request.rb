module Rack
  class ClientSpec
    class GotRequest
      class Response
        def inspect
          "#<Response>"
        end
        def initialize(response)
          @response = response
        end
        def status
          @response[0]
        end
        def headers
          @response[1]
        end
        def body
          @response[2]
        end
        def [](i)
          @response[i]
        end
      end

      attr_reader :env, :response

      def initialize(env, response)
        @env = env
        @response = Response.new(response)
      end
    end
  end
end
