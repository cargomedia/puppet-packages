require 'spec_helper'

describe package('bipbip-cm') do
  it { should be_installed.by('gem') }
end
