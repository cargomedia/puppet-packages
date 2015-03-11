require 'spec_helper'

describe 'apt::update' do

  describe command('stat -c "%Y" /var/cache/apt') do
    its(:stdout) { should_not match /0711171533/ }
  end

end
