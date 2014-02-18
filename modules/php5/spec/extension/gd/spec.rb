require 'spec_helper'

describe command('php -m') do
  its(:stdout) { should match /gd/ }
  its(:stdout) { should_not match /Warning.*gd.*loaded/ }
end
