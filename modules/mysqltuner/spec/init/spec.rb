require 'spec_helper'

describe package('mysqltuner') do
  it { should be_installed }
end
