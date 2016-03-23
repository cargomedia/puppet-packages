require 'spec_helper'

describe 'cm_janus' do

  describe file('/etc/fluentd/config.d/50-source-cm-janus.conf') do
    its(:content) { should match('path /var/log/cm-janus/cm-janus.log') }
  end

end
