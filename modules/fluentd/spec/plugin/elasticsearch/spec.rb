require 'spec_helper'

describe 'fluentd::plugin::elasticsearch' do

  describe command('fluentd --show-plugin-config=output:elasticsearch') do
    its(:exit_status) { should eq 0 }
  end

end
