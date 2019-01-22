require "socket"
require "msgpack"
require "./cache"

module Codb
  class CTCPServer

    def initialize(@hostname : String = "127.0.0.1", @port : Int8 | Int16 | Int32 | Int64 = 5000)
      @db = Codb::Cache.new
      @server = TCPServer.new(@hostname, @port)
    end

    def start
      @server.tcp_nodelay = true
      @server.recv_buffer_size = 4096
      puts "Started server on port 5000"
      while socket = @server.accept?
        puts "Connected client: #{socket}"
        spawn handle_client(socket)
      end
    end

    def handle_client(client)
      #unpack the hash
      time = Time.now
      data = Hash(String, MessagePack::Type).new(MessagePack::IOUnpacker.new(client))
      #puts data
      puts "[#{client}] - Unpacked: #{Time.now - time}"
      packer = MessagePack::Packer.new(client)
      case data["action"]
      when "set"
        result = @db.set(data["key"].to_s, data["value"])? "true" : "false"
      when "get"
        result = @db.get(data["key"].to_s)
      when "del"
        result = @db.del(data["key"].to_s)
      end
      client << packer.write({"msg" => result}) << "\n"
      puts Time.now - time
    end

  end
end
