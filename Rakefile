$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "pathname"
require "qchan_worker"
require "resque/tasks"

namespace :resque do
  task :setup do
    ENV["TERM_CHILD"] = "1" # Can be removed after Resque 2.0.0
    QchanWorker.setup
  end
end

namespace :doc do
  desc "Generate SVG files from doc/dot/*.dot"
  task :dot do
    Pathname.glob("doc/dot/*.dot").each do |dot|
      svg = Pathname.new("doc/png/#{dot.basename('.dot')}.png")
      svg.parent.mkpath
      dot.parent.mkpath
      sh "dot -o #{svg} -Tpng #{dot}"
    end
  end
end
