require 'spec_helper'

describe command('which node') do
  it { should return_exit_status 0 }
end

describe command('which npm') do
  it { should return_exit_status 0 }
end
