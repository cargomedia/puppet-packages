require 'spec_helper'

describe 'chromium' do

  describe command('chromium-browser --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match 'Chromium' }
  end

end
