require 'spec_helper'

describe 'monit::service_status' do

  describe command('monit summary') do
    its(:stdout) { should match /rsyslog+.+[ok|Running]/ }
  end
end
