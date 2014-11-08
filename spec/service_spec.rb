require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Server do
  connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new service' do
    it 'a name is required' do
      expect {
        connection.service.add(:serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      }.should raise_error(ArgumentError, /name/)
    end

    it 'a serverName is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serviceType => 'HTTP', :port => '80')
      }.should raise_error(ArgumentError, /serverName/)
    end

    it 'a serviceType is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serverName => 'foo', :port => '80')
      }.should raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serverName => 'foo', :serviceType => 'HTTP')
      }.should raise_error(ArgumentError, /port/)
    end


    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.service.add(:name => 'foo_80', :serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      result.should be_kind_of(Hash)
    end
  end

end
