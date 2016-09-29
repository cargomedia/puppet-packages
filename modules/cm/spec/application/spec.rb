require 'spec_helper'

describe 'cm::application' do

  describe file('/etc/systemd/system/critical-units.target.d/wants-cm-applications.target.conf') do
    it { should be_file }
  end
end
