require 'spec_helper'

describe command('nodejs -v') do
  it { should return_exit_status 0 }
end

describe command('node -v') do
  it { should return_exit_status 0 }
end

describe command('npm -v') do
  it { should return_exit_status 0 }
end
