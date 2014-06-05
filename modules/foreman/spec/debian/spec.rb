require 'spec_helper'

describe package('foreman_debian') do
  it { should be_installed.by('gem') }
end
