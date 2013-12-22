require "spec_helper"

describe QchanWorker::BuildJob do
  describe ".perform" do
    let(:attributes) do
      { "command" => command }
    end

    let(:command) do
      "echo hello world"
    end

    context "with error" do
      let(:command) do
        "echo hello; fail; echo world"
      end

      it "stops there" do
        result = described_class.perform(attributes)
        result[:status].should_not == 0
        result[:output].should_not include("world")
        result[:output].should include("fail")
      end
    end

    context "with multiline command" do
      let(:command) do
        "echo hello\necho world"
      end

      it "succeeds" do
        described_class.perform(attributes).should == { output: "hello\nworld\n", status: 0 }
      end
    end

    context "with valid condition" do
      it "executes given shell-script and returns its output & exit status" do
        described_class.perform(attributes).should == { output: "hello world\n", status: 0 }
      end
    end
  end
end
