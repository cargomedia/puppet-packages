require 'spec_helper'

describe 'apt::update' do

  describe command('stat -c "%Y" /var/lib/apt/periodic/update-success-stamp') do
    its(:stdout) { should_not match /12345/ }
  end

end
