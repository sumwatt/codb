require "./codb/*"
module Codb
  VERSION = "0.1.0"
end

server = Codb::CTCPServer.new
server.start
