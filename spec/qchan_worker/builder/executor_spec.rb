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
        described_class.execute(command).should == {
          exit_status: 127,
          output: "hello\n\nsh: fail: command not found\n",
        }
      end
    end
  end
end
