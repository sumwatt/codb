require "./codb/*"
module Codb
  VERSION = "0.1.0"
end

server = Codb:TCPServer.new
server.start
