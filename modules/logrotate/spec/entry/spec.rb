require 'spec_helper'

tests = [
    {:title => 'foo',
     :file_patterns => ['/var/log/foo/*.log', '/var/log/foo_bar.log'],
     :commands => [
         'create 640',
         'rotate 14',
         'compress',
         'daily',
         'delaycompress',
         'notifyempty'
     ],
    },
    {:title => 'bar',
     :file_patterns => ['/var/log/bar/*.log', '/var/log/bar_foo.log'],
     :commands => [
         'create 640 bar bar',
         'rotate 4',
         'compress',
         'monthly',
     ],
    }
]

tests.each do |test|
  path_to_file = '/etc/logrotate.d/' + test[:title]

  describe file(path_to_file) do
    it { should be_file }
  end

  test[:file_patterns].each do |pattern|
    describe file(path_to_file) do
      it { should contain pattern }
    end
  end

  test[:commands].each do |command|
    describe file(path_to_file) do
      it { should contain command }
    end
  end

  describe command("logrotate -d " + path_to_file) do
    it { should return_exit_status 0 }
  end
end


