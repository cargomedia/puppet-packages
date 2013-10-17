require 'spec_helper'

describe `vagrant ssh default -c 'sudo puppet module list'` do
  it { should include('puppetlabs-stdlib') }
end
