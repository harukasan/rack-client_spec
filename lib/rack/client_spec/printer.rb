require 'ansi'

module Rack
  class ClientSpec
    module Printer
      def print_initialized
        puts ANSI.white_on_blue{ " ClientSpec " } + ANSI.black_on_green{ " version #{Rack::ClientSpec::VERSION} " } 
      end

      def print_states(states)
        puts ANSI.white_on_blue{ " ClientSpec " } + ANSI.black_on_yellow{ " EXPECT REQUEST SEQUENCE (#{states.size}) " } 
        states.each do |name, sequence|
          state = ""
          sequence.each do |req|
            state += ANSI.yellow{ " -> " }
            if req[:passed]
              state += ANSI.black_on_green { req[:request].desc }
            else
              state += ANSI.white { req[:request].desc }
            end
          end
          puts " - #{name}:#{state}"
        end

        puts ""
      end

      def print_success(name)
        puts ANSI.black_on_green{ " SUCCESS " } + " #{name}"
      end

      def print_fail(name, result)
        puts ANSI.black_on_red{ " FAIL " } + " #{name}"
        puts result.error.to_s
      end

      module_function :print_initialized
      module_function :print_states
      module_function :print_success
      module_function :print_fail
    end
  end
end

