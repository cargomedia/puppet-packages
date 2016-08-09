require 'spec_helper'

describe 'librdkafka' do

  describe command('ls /usr/local/lib/librdkafka.so.1') do
    its(:exit_status) { should eq 0 }
  end
end
