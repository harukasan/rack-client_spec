
module Rack
  class ClientSpec
    class Result
      attr_reader :error

      def initialize(error = nil)
        @error = error
      end

      def success?
        @error.nil?
      end
    end
  end
end

