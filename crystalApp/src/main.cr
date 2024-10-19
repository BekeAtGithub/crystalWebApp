require "http/server"
require "socket"

VERSION = "1.0"

# Get the hostname of the system
hostname = Socket.gethostname

# Extract or set the node number, default to "01"
node_number = ENV["NODE_NUMBER"]? || "01"

server = HTTP::Server.new do |context|
  context.response.content_type = "text/html"
  context.response.print "<h1>Node-#{node_number}</h1>"
  context.response.print "<p>Version #{VERSION}</p>"
end

address = "0.0.0.0"
port = ENV["PORT"]? || 8080

puts "Listening on http://#{address}:#{port}"
server.listen(address, port.to_i)
