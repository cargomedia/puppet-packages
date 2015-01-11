require 'spec_helper'

describe package('jenkins') do
  it { should be_installed }
end

describe file('/var/lib/jenkins/credentials.xml') do
  its(:content) { should match '<id>jenkins@cluster-foo</id>' }
end
