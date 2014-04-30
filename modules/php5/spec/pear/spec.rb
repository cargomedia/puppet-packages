require 'spec_helper'

describe package('Auth') do
  it { should be_installed.by('pear') }
end
