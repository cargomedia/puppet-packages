require 'spec_helper'

describe 'composer::project' do

  describe command('/usr/local/lib/jsonlint/bin/jsonlint --help') do
    its(:exit_status) { should eq 0 }
  end
end
