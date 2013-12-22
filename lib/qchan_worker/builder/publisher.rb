module QchanWorker
  class Publisher
    class << self
      include Mem

      def publish(*args)
        instance.publish(*args)
      end

      def instance
        new
      end
      memoize :instance
    end

    attr_reader :redis

    def initialize
      @redis = Redis.new(
        host: QchanWorker.configuration.redis_host,
        port: QchanWorker.configuration.redis_port,
      )
    end

    def publish(message)
      @redis.publish(channel, message)
    end

    private

    def channel
      "logs"
    end
  end
end
