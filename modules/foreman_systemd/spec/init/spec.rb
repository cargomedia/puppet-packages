require 'spec_helper'

describe 'foreman_systemd::init' do
  describe command('foreman-systemd') do
    its(:exit_status) { should eq 1 }
    its(:stderr) { should match('Usage') }
    its(:stderr) { should match('Missing <command> param') }
  end

  describe command('foreman') do
    its(:exit_status) { should eq 0 }
  end
end
