require 'spec_helper'

describe package('uglify-js') do
  it { should be_installed.by('npm') }
end
