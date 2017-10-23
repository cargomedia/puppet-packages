require 'spec_helper'

describe 'bipbip::combined_with_revealcloud' do

  describe('tags are same both in revealcloud and bipbip') do
    describe command('systemctl show revealcloud --property=ExecStart --no-pager') do
      its(:stdout) { should match /-t foo -t bar/}
    end
    describe file('/etc/bipbip/config.yml') do
      its(:content) { should match /tags:\n  - foo\n  - bar\n/ }
    end
  end
end
