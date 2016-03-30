require 'spec_helper'

describe 'fluentd::plugin::loggly' do

  describe command('fluentd --show-plugin-config=output:loggly') do
    its(:exit_status) { should eq 0 }
  end

end
