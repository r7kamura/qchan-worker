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

    property :qchan_api_host do
      raise Error, "You must set QchanWorker.configuration.qchan_api_host"
    end

    property :qchan_api_port do
      80
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
