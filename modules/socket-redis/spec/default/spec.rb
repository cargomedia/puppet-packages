require 'spec_helper'

describe command('npm list socket-redis -g') do
  it { should return_stdout 'socket-redis@0.1.1' }
end
