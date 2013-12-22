require "qchan_worker/builder/executor"
require "qchan_worker/builder/reporter"

module QchanWorker
  class Builder
    def self.perform(*args)
      new(*args).perform
    end

    def initialize(attributes)
      @id = attributes["id"]
      @command = attributes["command"]
    end

    def perform
      report(execute)
    end

    private

    def execute
      Executor.execute(@command)
    end

    def report(result)
      Reporter.report(id: @id, result: result)
    end
  end
end
