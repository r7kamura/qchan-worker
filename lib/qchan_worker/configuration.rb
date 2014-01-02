require "mem"

module QchanWorker
  class Configuration
    include Mem

    def self.property(name, &default)
      define_method(name) do
        if properties.has_key?(name) || default.nil?
          properties[name]
        else
          properties[name] = default.call
        end
      end

      define_method("#{name}=") do |value|
        properties[name] = value
      end
    end

    property :qchan_api_access_token do
      ENV["QCHAN_API_ACCESS_TOKEN"]
    end

    property :qchan_api_scheme do
      ENV["QCHAN_API_SCHEME"] || "http"
    end

    property :qchan_api_host do
      ENV["QCHAN_API_HOST"] || "localhost"
    end

    property :qchan_api_port do
      ENV["QCHAN_API_PORT"] || "80"
    end

    property :redis_host do
      ENV["REDIS_HOST"] || "localhost"
    end

    property :redis_port do
      ENV["REDIS_PORT"] || "6379"
    end

    property :resque_queues do
      ENV["QUEUE"] || "builds"
    end

    private

    def properties
      {}
    end
    memoize :properties

    class Error < StandardError
    end
  end
end
