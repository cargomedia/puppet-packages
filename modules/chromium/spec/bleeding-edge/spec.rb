require 'spec_helper'

describe 'chromium:bleeding-edge' do

  describe command('chromium-browser --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Chromium 51' }
  end

end
