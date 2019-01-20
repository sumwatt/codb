require "msgpack"

module Codb
  class Cache
    def initialize
      @cache = {} of String => MessagePack::Type
    end

    def set(key : String, value : MessagePack::Type )
      @cache[key] = value
      true
    end

    def get(key : String)
      return @cache[key] == Nil ? false : @cache[key]
    end

    def del(key : String)
      @cache.delete(key) if @cache.has_key? key
      true
    end
  end
end
