require "qchan_worker/builder/executor"
require "qchan_worker/builder/reporter"

module QchanWorker
  class Builder
    include Mem

    def self.perform(*args)
      new(*args).perform
    end

    def initialize(attributes)
      @id = attributes["id"]
      @command = attributes["command"]
    end

    def perform
      reporter.start
      reporter.finish(execute)
    end

    private

    def execute
      Executor.execute(@command)
    end

    def reporter
      Reporter.new(id: @id)
    end
    memoize :reporter
  end
end
