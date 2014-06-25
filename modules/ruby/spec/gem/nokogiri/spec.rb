require 'spec_helper'

describe command('gem list') do
  its(:stdout) { should match 'nokogiri' }
end
