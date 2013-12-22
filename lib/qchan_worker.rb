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
      ENV["QUEUE"] = QchanWorker.configuration.resque_queues
    end

    def setup_resque_host
      Resque.redis = Redis.new(
        host: QchanWorker.configuration.redis_host,
        port: QchanWorker.configuration.redis_port,
      )
    end
  end
end
