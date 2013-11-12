require 'spec_helper'

describe command('node -v') do
  it { should return_stdout 'v0.10.4' }
end

describe command('npm -v') do
  it { should return_stdout '1.2.18' }
end
