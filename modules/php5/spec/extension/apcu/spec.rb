require 'spec_helper'

describe 'php5::extension::apcu' do

  describe command('php --ri apcu') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /apc.shm_size => 12M/ }
    its(:stdout) { should match /apc.mmap_file_mask => \/tmp\/foo./ }
  end

  describe command('php -r "apc_store(\"foo\", 12); echo apc_fetch(\"foo\");"') do
    its(:stdout) { should eq('12') }
  end

  describe command('php /opt/php5/apc-status.php') do
    its(:exit_status) { should eq(0) }
  end
end
