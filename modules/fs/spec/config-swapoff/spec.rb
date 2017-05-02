require 'spec_helper'

describe 'fs::config::swapoff' do

  describe command('test 0 -eq $(vmstat -s | grep "total swap" | sed ":a;s/^\([[:space:]]*\)[[:space:]]/\1/;ta" | cut -d " " -f 1)') do
    its(:exit_status) { should eq 0 }
  end
end
