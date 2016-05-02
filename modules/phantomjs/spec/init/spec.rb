require 'spec_helper'

describe 'phantomjs' do

  describe command('phantomjs --version') do
    its(:exit_status) { should eq 0 }
  end
end
