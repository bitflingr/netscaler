require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Server do
  connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new server' do
    it 'a name is required' do
      expect {
        connection.servers.add_server({'ipaddress'=>'123.123.123.123'})
      }.should raise_error(ArgumentError, /name/)

      expect {
        connection.servers.add({'ipaddress'=>'123.123.123.123'})
      }.should raise_error(ArgumentError, /name/)
    end

    it 'an ipaddress is required' do
      expect {
        connection.servers.add_server({'name'=>'hostname'})
      }.should raise_error(ArgumentError, /ipaddress/)

      expect {
        connection.servers.add({'name'=>'hostname'})
      }.should raise_error(ArgumentError, /ipaddress/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servers.add :name => 'foo', :domain => 'foo.bar.com'
      result.should be_kind_of(Hash)
    end
  end

  context 'when removing a server' do
    it ':server is required' do
      expect {
        connection.servers.remove({'ipaddress'=>'123.123.123.123'})
      }.should raise_error(ArgumentError, /server/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servers.remove :server => 'foo'
      result.should be_kind_of(Hash)
    end
  end

end
