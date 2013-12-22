require "open3"

module QchanWorker
  class Builder
    class Executor
      def self.execute(*args)
        new(*args).execute
      end

      def initialize(command)
        @command = command
      end

      def execute
        result = invoke
        { exit_status: result[1].to_i, output: result[0] }
      end

      private

      def invoke
        Open3.capture2e(script)
      end

      def script
        "set -e; #{@command.strip.gsub(/\r\n|\n/, ?;)}"
      end
    end
  end
end
