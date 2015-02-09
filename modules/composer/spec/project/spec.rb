require 'spec_helper'

describe command('/usr/local/lib/jsonlint/bin/jsonlint --help') do
  its(:exit_status) { should eq 0 }
end
