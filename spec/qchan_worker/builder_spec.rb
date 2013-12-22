require "spec_helper"

describe QchanWorker::Builder do
  describe "#execute" do
    let(:job) do
      described_class.new(attributes)
    end

    let(:attributes) do
      { "command" => command }
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
      let(:command) do
        "echo hello world"
      end

      it "executes it" do
        job.execute
        job.status.should == 0
        job.output.should == "hello world\n"
      end
    end
  end
end
