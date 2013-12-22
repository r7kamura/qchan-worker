require "spec_helper"

describe QchanWorker::BuildJob do
  describe ".perform" do
    let(:attributes) do
      { "command" => "echo hello world" }
    end

    it "executes given shell-script and returns its output & exit status" do
      described_class.perform(attributes).should == { output: "hello world\n", status: 0 }
    end
  end
end
