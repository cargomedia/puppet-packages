require 'spec_helper'

describe 'satis::repo' do

  describe file('/var/lib/satis/public/foo') do
    it { should be_directory }
    it { should be_owned_by 'satis' }
  end

  describe file('/var/lib/satis/public/bar') do
    it { should be_directory }
    it { should be_owned_by 'satis' }
  end

  describe file('/var/lib/satis/public/foo/packages.json') do
    it { should be_file }
    it { should be_owned_by 'satis' }
    it { should be_readable.by_user('nginx') }
  end

  describe command('grep -r "https://api.github.com/repos/twigphp/Twig/zipball/ca445842fcea4f844d68203ffa2d00f5e3cdea64" /var/lib/satis/public/foo/include') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/lib/satis/public/bar/packages.json') do
    it { should be_file }
    it { should be_owned_by 'satis' }
    it { should be_readable.by_user('nginx') }
  end

  describe command('grep -r "https://example.local/bar/dist/twig-twig-ca445842fcea4f844d68203ffa2d00f5e3cdea64-zip-db7c39.zip" /var/lib/satis/public/bar/include') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/lib/satis/public/bar/dist/twig-twig-ca445842fcea4f844d68203ffa2d00f5e3cdea64-zip-db7c39.zip') do
    it { should be_file }
    it { should be_owned_by 'satis' }
    it { should be_readable.by_user('nginx') }
  end

  describe command('curl --proxy "" -vkL http://example.local/foo') do
    its(:stderr) { should match /https+.*example\.local/}
    its(:stderr) { should match /200 OK/}
    its(:stdout) { should match /foo Composer Repository/}
  end
end
