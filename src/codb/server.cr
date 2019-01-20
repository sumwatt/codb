require "socket"
require "mesgpack"
require "./cache"

module Codb
  class TCPServer

    def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 = 5000)
      @db = Codb::Cache.new
    end

    def start
      @server = TCPServer.new(@hostname, @port)
      @server.tcp_nodelay = true
      @server.recv_buffer_size = 4096
      while socket = @server.accept?
        puts "Connected client: #{socket}"
        spawn handle_client(socket)
      end
    end

    def handle_client(client)
      #unpack the hash
      data = Hash(String, MessagePack::Type).new(MessagePack::IOUnpacker.new(client))
      #puts "[#{client}] Message: #{data}"
      packer = MessagePack::Packer.new(client)
      case data["action"]
      when "set"
        result = @db.set(data["key"].to_s, data["value"])
      when "get"
        result = @db.get(data["key"].to_s)
      when "del"
        result = @db.del(data["key"].to_s)
      end
      packer.write({"msg" => result})
    end

  end
end
