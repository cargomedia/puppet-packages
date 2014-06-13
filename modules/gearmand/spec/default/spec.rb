require 'spec_helper'

describe user('foogear') do
  it { should exist }
end

describe command('/usr/local/sbin/gearmand --version') do
  its(:stdout) { should match('1.1.2') }
end

describe service('gearman-job-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(4730) do
  it { should be_listening }
end

describe file('/etc/gearmand/gearmand.conf') do
  it { should be_file }
end

['/var/run/gearman-job-server', '/var/log/gearman-job-server' ].each do |directory|
  describe file(directory) do
    it { should be_directory }
    it { should be_owned_by 'foogear' }
    it { should be_mode 755 }
  end
end

describe command('lsof | grep gearmand | grep -q gearman-persist.sqlite3') do
  it { should return_exit_status 1 }
end
