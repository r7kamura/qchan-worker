require "mem"
require "open3"
require "qchan_worker/builder/publisher"
require "tempfile"

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
        str = "/bin/bash -e #{tempfile.path}"
        str = "docker run -w #{tempdir}:/tempdir #{image} #{str}" if has_docker?
        str
      end

      def on_printed(line)
        lines << line
        Publisher.publish(line: line)
      end

      def on_finished(thread)
        @exit_status = thread.value.exitstatus
      end

      def tempfile
        file = Tempfile.new("script")
        file << @command
        file.close
        file
      end
      memoize :tempfile

      def tempdir
        File.dirname(tempfile)
      end

      def lines
        []
      end
      memoize :lines

      def has_docker?
        !`which docker`.empty?
      end

      def image
        "worker"
      end
    end
  end
end
