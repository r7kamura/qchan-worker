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

  describe "#execute" do
    let(:job) do
      described_class.new(attributes)
    end

    context "with error" do
      let(:command) do
        "echo hello; fail; echo world"
      end

      it "stops there" do
        job.execute
        job.status.should_not == 0
        job.output.should include("hello")
        job.output.should include("fail")
        job.output.should_not include("world")
      end
    end

    context "with multiline command" do
      let(:command) do
        "echo hello\necho world"
      end

      it "executes it" do
        job.execute
        job.status.should == 0
        job.output.should == "hello\nworld\n"
      end
    end

    context "with oneline command" do
      it "executes it" do
        job.execute
        job.status.should == 0
        job.output.should == "hello world\n"
      end
    end
  end
end
