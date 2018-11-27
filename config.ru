require "greeter"

use Rack::Reloader, 0

run Greeter

#run Rack::Cascade.new([Rack::File.new("public"), Greeter])
