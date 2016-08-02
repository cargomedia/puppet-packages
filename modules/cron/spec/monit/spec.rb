require 'spec_helper'

describe 'cron::monit' do
  describe command('monit summary') do
    its(:stdout) { should match /cron.*[Running|Status ok]/ }
  end
end
