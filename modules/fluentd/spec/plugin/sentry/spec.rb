require 'spec_helper'

describe 'fluentd::plugin::sentry' do

  describe command('if (test -e /bin/systemctl);fluentd --show-plugin-config=output:sentry;else true;fi') do
    its(:exit_status) { should eq 0 }
  end

end
