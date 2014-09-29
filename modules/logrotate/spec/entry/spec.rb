require 'spec_helper'

spec_commands = [
  'rotate 7',
  'compress',
  'daily',
  'create',
  'delaycompress',
  'missingok'
]

logrotate_file = '/etc/logrotate.d/foo'

describe file(logrotate_file) do
  it { should contain '/var/log/foo/*.log' }
  spec_commands.each do |command|
    it { should contain command }
  end
end

describe command("logrotate -d " + logrotate_file) do
  it { should return_exit_status 0 }
end

2.times do
  describe command("logrotate -f " + logrotate_file) do
    it { should return_exit_status 0 }
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

