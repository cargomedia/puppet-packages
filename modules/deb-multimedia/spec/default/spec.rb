require 'spec_helper'

describe package('deb-multimedia-keyring') do
  it { should be_installed }
end
