require 'spec_helper'

describe 'fluentd::plugin::forest' do

  describe command('fluentd --show-plugin-config=output:forest') do
    its(:exit_status) { should eq 0 }
  end

end
