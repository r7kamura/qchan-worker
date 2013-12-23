$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "qchan_worker"
require "webmock/rspec"

QchanWorker.configuration.qchan_api_host = "example.com"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Stub Redis.
  config.before do
    QchanWorker::Publisher.stub(:publish)
  end
end
