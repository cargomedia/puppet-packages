require 'spec_helper'

describe 'fluentd::plugin::record_modifier' do

  describe command('fluentd --show-plugin-config=output:record_modifier') do
    its(:exit_status) { should eq 0 }
  end

end
