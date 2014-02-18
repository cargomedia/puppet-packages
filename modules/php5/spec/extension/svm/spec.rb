require 'spec_helper'

describe command('php --ri svm') do
  it { should return_exit_status 0 }
  its(:stdout) { should_not match /Warning.*svm.*loaded/ }
end
