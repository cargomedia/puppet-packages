require 'spec_helper'

describe 'php5::extension::ssh2' do

  describe command('php --ri ssh2') do
    its(:exit_status) { should eq 0 }
  end
end
