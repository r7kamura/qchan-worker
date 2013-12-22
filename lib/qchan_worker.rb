require "resque"
require "qchan_worker/builder"
require "qchan_worker/configuration"

module QchanWorker
  class << self
    include Mem

    def configuration
      Configuration.new
    end
    memoize :configuration

    def setup
      setup_resque_env
      setup_resque_host
    end

    private

    def setup_resque_env
      ENV["QUEUE"] ||= "builds"
      ENV["REDIS_HOST"] ||= "localhost"
      ENV["REDIS_PORT"] ||= "6379"
    end

    def setup_resque_host
      Resque.redis = Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"])
    end
  end
end
