require 'spec_helper'

describe 'fluentd' do

  describe command('fluentd --version') do
    its(:exit_status) { should eq 0 }
  end

  describe service('fluentd') do
    it { should be_running }
  end

  describe port(24220) do
    it { should be_listening }
  end

  describe file('/etc/fluentd/config.d/50-filter_record_transformer-hostname.conf') do
    it { should be_file }
  end

  describe file('/etc/fluentd/config.d/50-filter_record_transformer-streamline_level.conf') do
    it { should be_file }
  end

  describe command('grep -rh debug-1 /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'info',
                       message: 'debug-1',
                       hostname: /.+/,
                     )
    end
  end

  describe command('grep -rh debug-2 /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'warning',
                       message: 'debug-2',
                       hostname: /.+/,
                     )
    end
  end

  describe command('grep -rh debug-3 /tmp/dump*') do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      is_expected.to include_json(
                       level: 'custom',
                       message: 'debug-3',
                       hostname: /.+/,
                     )
    end
  end
end
