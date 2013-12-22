require "spec_helper"

describe QchanWorker::Builder do
  let(:attributes) do
    { "id" => build_id, "command" => command }
  end

  let(:build_id) do
    1
  end

  let(:command) do
    "echo hello world"
  end

  describe ".perform" do
    it "executes a given command and report the result to Qchan API as JSON" do
      stub_request(
        :put,
        "#{QchanWorker.configuration.qchan_api_host}/builds/#{build_id}",
      ).with(
        body: { exit_status: 0, output: "hello world\n" }.to_json,
      )
      described_class.perform(attributes)
    end
  end
end
