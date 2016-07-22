require 'spec_helper'

describe 'apt::config' do

  describe file('/etc/apt/apt.conf.d/999-some-uniq-name') do
    it { should be_file }
  end

  describe command('ls /var/lib/apt/apt-dpkg-pre-stamp-* | wc -l') do
    its(:stdout) { should match /1/ }
  end

  describe command('ls /var/lib/apt/apt-dpkg-post-stamp-* | wc -l') do
    its(:stdout) { should match /1/ }
  end

end
