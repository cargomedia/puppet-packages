require 'spec_helper'

describe command('php --re apc | grep "apc version"') do
  its(:stdout) { should match 'apc version 3.1.13 ' }
end
