require "faraday"
require "open3"

module QchanWorker
  class Builder
    def self.perform(*args)
      new(*args).perform
    end

    def initialize(attributes)
      @id = attributes["id"]
      @command = attributes["command"]
    end

    def perform
      execute
      report
    end

    def execute
      @result = Open3.capture2e(command)
    end

    def command
      "set -e; "+ @command.gsub(/\r\n|\n/, ";")
    end

    def output
      @result && @result[0]
    end

    def status
      @result && @result[1]
    end

    def report
      Faraday.put(api_url, api_parameters, "Content-Type" => "application/json")
    end

    def api_parameters
      { exit_status: status.to_i, output: output }.to_json
    end

    def api_url
      "http://#{api_host}:#{api_port}/builds/#@id"
    end

    def api_host
      QchanWorker.configuration.qchan_api_host
    end

    def api_port
      QchanWorker.configuration.qchan_api_port
    end
  end
end
