require "open3"

module QchanWorker
  class BuildJob
    def self.perform(*args)
      new(*args).perform
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def perform
      { output: output, status: status.success? }
    end

    private

    def command
      "set -e; "+ @attributes["command"].gsub(/\r\n|\n/, ";")
    end

    def output
      result[0]
    end

    def status
      result[1]
    end

    def result
      @result ||= Open3.capture2e(command)
    end
  end
end
