require 'spec_helper'

describe command('npm list redis -g') do
  its(:stdout) { should match 'redis' }
end
