require "faraday"

module QchanWorker
  class Builder
    class Reporter
      def self.report(*args)
        new(*args).report
      end

      def initialize(attributes)
        @id = attributes[:id]
      end

      def start
        report(started_at: Time.now.iso8601)
      end

      def finish(result)
        report(finished_at: Time.now.iso8601, exit_status: result[:exit_status], output: result[:output])
      end

      private

      def report(attributes)
        http_client.put(url, attributes.to_json, header)
      end

      def http_client
        Faraday
      end

      def body
        { exit_status: @exit_status, output: @output }.to_json
      end

      def header
        { "Authorization" => "Bearer #{access_token}", "Content-Type" => "application/json" }
      end

      def url
        "#{scheme}://#{host}:#{port}/builds/#@id"
      end

      def scheme
        QchanWorker.configuration.qchan_api_scheme
      end

      def host
        QchanWorker.configuration.qchan_api_host
      end

      def port
        QchanWorker.configuration.qchan_api_port
      end

      def access_token
        QchanWorker.configuration.qchan_api_access_token
      end

      class Error < StandardError
      end
    end
  end
end
