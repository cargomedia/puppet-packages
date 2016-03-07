require 'spec_helper'

describe 'cm::services::janus' do

  # cm-janus cannot run without cm-api https://github.com/cargomedia/puppet-packages/issues/1196
  # describe port(8100) do
  #   it { should be_listening }
  # end

  # cm-janus cannot run without cm-api https://github.com/cargomedia/puppet-packages/issues/1196
  # describe service('cm-janus') do
  #   it { should be_enabled }
  #   it { should be_running }
  # end

  describe service('janus_standalone') do
    it { should be_enabled }
    it { should be_running }
  end
end
