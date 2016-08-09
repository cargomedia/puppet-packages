require 'spec_helper'

describe 'daemon' do

  describe service('my-program') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process('my-program') do
    its(:user) { should eq 'alice' }
    its(:args) { should match /--foo=12/ }
    it { should be_running }
  end

  describe command('ps --no-headers -o nice -p $(pgrep -f "^/bin/bash /tmp/my-program")') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /19/ }
  end

  describe command('cat /proc/$(pgrep -f "^/bin/bash /tmp/my-program")/oom_score_adj') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /-500/ }
  end

  describe command('cat /proc/$(pgrep -f "^/bin/bash /tmp/my-program")/environ') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /DISPLAY=:99/ }
    its(:stdout) { should match /FOO=BOO/ }
  end

  describe command('cat /proc/$(pgrep -f "^/bin/bash /tmp/my-program")/limits') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /Max cpu time+.+25+.+25+.+seconds/ }
    its(:stdout) { should match /Max file size+.+unlimited+.+unlimited+.+bytes/ }
    its(:stdout) { should match /Max core file size+.+0+.+unlimited+.+bytes/ }
    its(:stdout) { should match /Max resident set+.+4194304+.+4194304+.+bytes/ }
    its(:stdout) { should match /Max processes+.+300+.+300+.+processes/ }
    its(:stdout) { should match /Max open files+.+9999+.+9999+.+files/ }
    its(:stdout) { should match /Max address space+.+unlimited+.+unlimited+.+bytes/ }
  end

  describe file('/run/my-program') do
    it { should be_directory }
    it { should be_mode 700 }
  end

  describe command('find /tmp/created_by_pre -type f ! -mmin +1') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/tmp/copied_by_post') do
    it { should be_file }
  end
end
