require 'spec_helper'

describe 'network::route' do

  describe command('ip route show') do
    its(:stdout) { should match /default via 127\.0\.0\.2/ }
    its(:stdout) { should match /127\.9\.9\.6 via 127\.0\.0\.3/ }
  end
end

