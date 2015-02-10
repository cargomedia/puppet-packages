require 'spec_helper'

describe command('/usr/local/lib/jsonlint/bin/jsonlint --help') do
  it { should return_exit_status 0 }
end
