require 'power_assert'

module Rack
  class ClientSpec
    class Assertion < Exception
    end

    module Assertions
      def assert(&block)
        PowerAssert.start(block, assertion_method: __callee__) do |pa|
          unless pa.yield
            raise Assertion, pa.message_proc.call
          end
        end
      end
    end
  end
end

