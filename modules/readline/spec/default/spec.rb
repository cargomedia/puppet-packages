require 'spec_helper'

describe 'readline' do

  describe file('/usr/lib/x86_64-linux-gnu/libreadline.so') do
    it { should be_file }
  end

end
