require 'spec_helper'

describe command('/var/lib/satis/satis/bin/satis') do
  it { should return_exit_status 0 }
end
