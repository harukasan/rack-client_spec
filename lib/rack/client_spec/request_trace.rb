module Rack
  class ClientSpec
    class RequestTrace
      attr_reader :match

      def initialize(sequences)
        @pointers = {}
        @sequences = {}
        @match = nil
        sequences.each do |name, sequence|
          set_sequence name, sequence
        end
      end

      def set_sequence(name, sequence)
        @sequences[name] = sequence
        @pointers[name] = 0
      end

      def reset(name)
        @pointers[name] = 0
      end

      def trace(env)
        @sequences.each do |name, sequence|
          next unless sequence[@pointers[name]].match?(env)
          @pointers[name] += 1
          if @pointers[name] == sequence.length
            @match = name
            break
          end
        end
        !@match.nil?
      end

      def states
        states = {}
        @sequences.each do |name, sequence|
          states[name] = []
          sequence.each_with_index do |request, i|
            states[name] << {
              passed: @pointers[name] > i,
              request: request,
            }
          end
        end

        states
      end
    end
  end
end

