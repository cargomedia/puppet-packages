require 'spec_helper'

describe command('/usr/local/revealcloud/revealcloud -V') do
  it { should return_exit_status 0 }
end
