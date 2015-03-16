require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Policy::Stringmap do
  connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new stringmap' do
    specify 'a name is required' do
      expect {
        connection.policy.stringmap.add('test')
      }.to raise_error(ArgumentError, /payload must be a hash\./)
    end

    it 'returns a hash if proper arguments are passed' do
      result = connection.policy.stringmap.add(:name => 'test')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when getting a list of stringmaps' do
    specify 'a name is optional' do
      result = connection.policy.stringmap.list(:name => 'test')
      expect(result).to be_kind_of(Hash)
    end

    specify 'the arg should be a hash' do
      expect {
        connection.policy.stringmap.list('test')
      }.to raise_error(ArgumentError, /payload must be a hash\./)
    end

    it 'returns a hash, listing stringmaps' do
      result = connection.policy.stringmap.list
      expect(result).to be_kind_of(Hash)
    end

    it 'Method Get will take name parameter and return hash' do
      result = connection.policy.stringmap.get(:name => 'test')
      expect(result).to be_kind_of(Hash)
    end

    specify 'Method Get, arg should be a hash' do
      expect {
        connection.policy.stringmap.get('test')
      }.to raise_error(ArgumentError, /payload must be a hash\./)
    end

  end

  context 'when adding a binding a key value pair to a stringmap' do
    specify 'a name is required' do
      expect {
        connection.policy.stringmap.bind(:key => 'foo', :value => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    specify 'a key is required' do
      expect {
        connection.policy.stringmap.bind(:name => 'foo', :value => 'bar')
      }.to raise_error(ArgumentError, /key/)
    end

    specify 'a value is required' do
      expect {
        connection.policy.stringmap.bind(:key => 'foo', :name => 'bar')
      }.to raise_error(ArgumentError, /value/)
    end

    it 'returns a hash if proper arguments are passed' do
      result = connection.policy.stringmap.bind(:name => 'test', :key => 'foo', :value => 'bar')
      expect(result).to be_kind_of(Hash)
    end
 end


end