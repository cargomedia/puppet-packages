require 'spec_helper'

describe 'fluentd::plugin::systemd' do

  describe command('fluentd --show-plugin-config=output:systemd') do
    its(:exit_status) { should eq 0 }
  end

end
