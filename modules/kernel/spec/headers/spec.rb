require 'spec_helper'

describe 'kernel::headers' do

  describe command('test -d /lib/modules/$(uname -r)/build/include') do
    its(:exit_status) { should eq 0 }
  end

end
