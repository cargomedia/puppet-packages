require 'spec_helper'

describe package('wpasupplicant') do
  it { should be_installed }
end
