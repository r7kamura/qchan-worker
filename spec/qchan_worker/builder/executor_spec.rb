require "spec_helper"

describe QchanWorker::Builder::Executor do
  describe ".execute" do
    context "with no error" do
      let(:command) do
        "echo hello world"
      end

      it "executes a given command and returns exit status & output" do
        described_class.execute(command).should == {
          exit_status: 0,
          output: "hello world\n",
        }
      end
    end

    context "with error" do
      let(:command) do
        "echo hello\nfail\necho world"
      end

      it "executes a given command and returns exit status & output" do
        result = described_class.execute(command)
        result[:exit_status].should == 127
        result[:output].should include("hello")
        result[:output].should include("fail: command not found")
        result[:output].should_not include("world")
      end
    end
  end
end
