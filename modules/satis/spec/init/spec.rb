require 'spec_helper'

describe 'satis' do

  describe user('satis') do
    it { should exist }
    it { should have_home_directory '/var/lib/satis' }
  end

  describe file('/var/lib/satis/satis/.git') do
    it { should be_directory }
    it { should be_owned_by 'satis' }
  end

  describe command('curl --proxy "" -vkL http://foo.local') do
    its(:stderr) { should match /https+.*foo\.local/}
    its(:stderr) { should match /403 Forbidden/}
  end
end
