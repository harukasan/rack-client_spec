require 'rack'
require 'rack/lobster'
require 'rack/client_spec'
require 'lobster_spec'

use Rack::ClientSpec, LobsterSpec
run Rack::Lobster.new
