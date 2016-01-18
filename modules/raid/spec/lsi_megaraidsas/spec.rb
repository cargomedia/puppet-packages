require 'spec_helper'

describe 'raid::lsi_megaraidsas' do

  describe command('monit summary') do
    its(:stdout) { should match /Program 'raid-lsi'/ }
  end
end
