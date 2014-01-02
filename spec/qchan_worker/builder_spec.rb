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
    it "executes a given command with reporting" do
      stub_request(:put, "#{QchanWorker.configuration.qchan_api_host}/builds/#{build_id}")
      described_class.perform(attributes)
    end
  end
end
