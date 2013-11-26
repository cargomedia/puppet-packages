require 'spec_helper'

describe command('php --re ssh2') do
  it { should return_exit_status 0 }
end
