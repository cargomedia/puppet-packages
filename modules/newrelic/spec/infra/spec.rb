require 'spec_helper'

describe 'newrelic::infra' do
  describe package('newrelic-infra') do
    it { should be_installed }
  end

  describe service('newrelic-infra') do
    it { should be_enabled }
  end

  describe command('systemctl list-dependencies --plain critical-units.target | grep newrelic-infra.service') do
    its(:exit_status) { should eq 0 }
  end
end
