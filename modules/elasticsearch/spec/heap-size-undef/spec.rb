require 'spec_helper'

describe 'elasticsearch heap-size-undef' do

  # Wait for elasticsearch to start up
  describe command('timeout --signal=9 30 bash -c "while ! (curl -s http://localhost:9200/); do sleep 0.5; done"') do
    its(:exit_status) { should eq 0 }
  end

  describe command('ps aux | grep elasticsearch') do
    its(:stdout) { should match 'java -Xms1g -Xmx1g' }
  end
end
