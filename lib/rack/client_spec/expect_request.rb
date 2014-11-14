module Rack
  class ClientSpec
    class ExpectRequest
      attr_reader :path, :env

      def initialize(method, path, env = {})
        env["REQUEST_METHOD"] = method
        @path = path
        @env = env
      end

      def match?(env)
        match_path?(env) && match_env?(env)
      end

      def match_path?(env)
        path = [env['PATH_INFO'], env['QUERY_STRING']].join '?'
        path = path.chop if path[-1] == "?"
        @path === path
      end

      def match_env?(env)
        !@env.each{|k, v| break unless env[k] == v}.nil?
      end

      def desc
        "#{@env['REQUEST_METHOD']} #{@path}"
      end
    end
  end
end


