require 'spec_helper'

describe 'nginx::log' do

  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
    its(:content) { should match /log_format+.+slim+.+\$request+.+\$request_body+.+\$status/ }
    its(:content) { should match /access_log+.+syslog:server=unix/ }
  end

  describe command('journalctl --unit=nginx --no-pager') do
    its(:stdout) { should match /GET \/bla HTTP\/1\.1/ }
    its(:stdout) { should match /POST \/ HTTP\/1\.1 \{\\x22foo\\x22: \\x22bar\\x22\}/ }
  end
end
