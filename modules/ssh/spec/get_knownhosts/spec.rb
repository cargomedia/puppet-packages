require 'spec_helper'

describe 'ssh:get_knownhosts' do

  describe file('/tmp/results_from_custom_func') do
    its(:content) { should match /foo/ }
    its(:content) { should match /192\.168\.200\.1/ }
    its(:content) { should match /192\.168\.200\.1/ }
    its(:content) { should_not match /192\.168\.111\.1/ }
  end

end
