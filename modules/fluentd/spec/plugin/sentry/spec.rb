require 'spec_helper'

describe 'fluentd::plugin::sentry' do

  describe command('fluentd --show-plugin-config=output:sentry') do
    its(:exit_status) { should eq 0 }
  end

end
