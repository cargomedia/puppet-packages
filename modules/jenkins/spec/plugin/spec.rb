require 'spec_helper'

describe file('/var/lib/jenkins/plugins/git.hpi') do
  it { should be_file }
  it { should be_owned_by 'jenkins' }
end

describe file('/var/lib/jenkins/plugins/ghprb.hpi') do
  it { should be_file }
  it { should be_owned_by 'jenkins' }
end
