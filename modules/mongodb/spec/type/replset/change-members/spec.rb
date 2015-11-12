require 'spec_helper'
require 'json'

describe 'mongodb_replset change members' do

  describe command('mongo --quiet --host localhost --port 27002 --eval "printjson(rs.status())"') do

    let(:status) {
      output = subject.stdout
      output.gsub!(/ISODate\((.+?)\)/, '\1 ')
      output.gsub!(/Timestamp\((.+?)\)/, '[\1]')
      output.gsub!(/ObjectId\((.+?)\)/, '1')
      JSON.parse(output)
    }

    let(:members) {
      status['members']
    }

    it 'repl has name' do
      expect(status['set']).to eq('my-repl')
    end
  end
end
