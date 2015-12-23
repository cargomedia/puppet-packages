require 'spec_helper'

describe 'bash' do

  describe file('/etc/bash.bashrc') do
    it { should be_file }
    its(:content) { should include 'PS1=\'\u# \'' }
  end

end
