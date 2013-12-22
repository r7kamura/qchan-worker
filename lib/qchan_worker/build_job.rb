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
      execute
      report
    end

    def execute
      @result = Open3.capture2e(command)
    end

    def command
      "set -e; "+ @attributes["command"].gsub(/\r\n|\n/, ";")
    end

    def output
      @result && @result[0]
    end

    def status
      @result && @result[1]
    end

    def report
    end
  end
end
