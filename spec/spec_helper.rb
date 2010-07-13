SPEC_DIR = File.expand_path(File.dirname(__FILE__))

$LOAD_PATH.unshift(SPEC_DIR)
$LOAD_PATH.unshift(File.join(SPEC_DIR, '..', 'lib'))

require 'ssdeep'
require 'spec'
require 'spec/autorun'

SAMPLE_DIR = File.join(SPEC_DIR, 'samples')

def sample_message(filename)
  dat = File.read(sample_file(filename))
  dat.force_encoding('ASCII-8BIT') if RUBY_VERSION >= "1.9"
  dat
end

def sample_file(filename)
  File.join(SAMPLE_DIR, filename)
end

Spec::Runner.configure do |config|
end
