require 'spec_helper'

describe package('apache2') do
  it { should be_installed }
end
