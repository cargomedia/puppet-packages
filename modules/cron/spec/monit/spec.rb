require 'spec_helper'

describe 'cron::monit' do
  describe command('monit summary') do
    its(:stdout) { should match /crond.*[Running|Status ok]/ }
  end
end
