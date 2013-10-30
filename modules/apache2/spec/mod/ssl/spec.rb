require 'spec_helper'

describe command('apachectl -M') do
  its(:stdout) { should match 'ssl_module' }
end
