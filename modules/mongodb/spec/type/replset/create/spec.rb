require 'spec_helper'
require 'json'

describe 'mongodb_replset create' do

  describe command('mongo --quiet --host localhost --port 27001 --eval "printjson(rs.status())"') do

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

    it 'contains one primary' do
      expect(members.select { |m| m['stateStr'] == 'PRIMARY' }.count).to eq(1)
    end

    it 'contains one secondary' do
      primary = members.select { |m| m['stateStr'] == 'PRIMARY' }.first
      secondaries = members.select { |m| m['stateStr'] == 'SECONDARY' }

      expect(secondaries.count).to eq(1)
      expect(secondaries.first['syncingTo']).to eq(primary['name'])
    end

    it 'contains one arbiter' do
      arbiters = members.select { |m| m['stateStr'] == 'ARBITER' }

      expect(arbiters.count).to eq(1)
      expect(arbiters.first['name']).to eq('localhost:27003')
    end
  end
end
