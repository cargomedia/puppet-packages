require 'spec_helper'

describe 'helper::script' do

  describe file('/tmp/file2') do
    it { should be_file }
    it { should be_owned_by 'alice' }
    its(:content) { should eq("hello2\n") }
  end

end
