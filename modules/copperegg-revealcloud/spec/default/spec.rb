require 'spec_helper'

describe command('/usr/local/revealcloud/revealcloud -V') do
  it { should return_exit_status 0 }
  its(:stderr) { should match /v3\.3-9-g06271da/ }
end

describe service('revealcloud') do
  it { should be_enabled }
  it { should be_running }
end
