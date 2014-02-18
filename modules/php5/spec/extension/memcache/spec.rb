require 'spec_helper'

describe command('php -m') do
  its(:stdout) { should match /memcache/ }
  its(:stdout) { should_not match /Warning.*memcache.*loaded/ }
end
