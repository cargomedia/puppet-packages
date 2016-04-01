require 'spec_helper'

spec_commands = [
  'rotate 10',
  'daily',
  'create 0640',
  'ifempty',
]

logrotate_file = '/etc/logrotate.d/foo'

describe 'logrotate::entry' do

  describe file(logrotate_file) do
    it { should contain '/var/log/foo/*.log' }
    spec_commands.each do |command|
      it { should contain command }
    end
  end

  describe command("logrotate -d " + logrotate_file) do
    its(:exit_status) { should eq 0 }
  end

  2.times do
    describe command("logrotate -f /etc/logrotate.conf") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(logrotate_file) do
    it { should be_file }
  end

  describe file('/var/log/foo/bar.log.2.gz') do
    it { should be_file }
  end

  describe command('cat /tmp/test | wc -l') do
    its(:stdout) { should match /2/ }
  end
end
