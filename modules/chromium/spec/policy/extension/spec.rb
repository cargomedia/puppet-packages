require 'spec_helper'

describe 'chromium::policy::extension' do

  describe file('/home/bob/.config/chromium/Default/Extensions/oeacdmeoegfagkmiecjjikpfgebmalof') do
    it { should be_directory }
  end

end
