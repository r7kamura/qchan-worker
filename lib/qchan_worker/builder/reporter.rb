require "faraday"

module QchanWorker
  class Builder
    class Reporter
      def self.report(*args)
        new(*args).report
      end

      def initialize(attributes)
        @id = attributes[:id]
        @output = attributes[:result][:output]
        @exit_status = attributes[:result][:exit_status]
      end

      def report
        http_client.put(url, body, header)
      end

      private

      def http_client
        Faraday
      end

      def body
        { exit_status: @exit_status, output: @output }.to_json
      end

      def header
        { "Content-Type" => "application/json" }
      end

      def url
        "#{scheme}://#{host}:#{port}/builds/#@id"
      end

      def scheme
        QchanWorker.configuration.qchan_api_scheme
      end

      def host
        QchanWorker.configuration.qchan_api_host or
          raise Error, "You must set QchanWorker.configuration.qchan_api_host"
      end

      def port
        QchanWorker.configuration.qchan_api_port
      end

      class Error < StandardError
      end
    end
  end
end
