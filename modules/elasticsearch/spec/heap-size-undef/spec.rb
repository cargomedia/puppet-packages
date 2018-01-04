require 'spec_helper'

describe 'elasticsearch heap-size-undef' do

  describe command('ps aux | grep elasticsearch') do
    its(:stdout) { should match 'java -Xms1g -Xmx1g' }
  end
end
