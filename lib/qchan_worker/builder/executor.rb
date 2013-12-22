require "open3"
require "mem"

module QchanWorker
  class Builder
    class Executor
      include Mem

      def self.execute(*args)
        new(*args).execute
      end

      def initialize(command)
        @command = command
      end

      def execute
        invoke
        { exit_status: @exit_status, output: lines.join("\n") }
      end

      private

      def invoke
        Open3.popen2e(script) do |input, output, thread|
          while line = output.gets
            on_printed(line)
          end
          on_finished(thread)
        end
      end

      def script
        "set -e; #{@command.strip.gsub(/\r\n|\n/, ?;)}"
      end

      def on_printed(line)
        lines << line
      end

      def on_finished(thread)
        @exit_status = thread.value.exitstatus
      end

      def lines
        []
      end
      memoize :lines
    end
  end
end
