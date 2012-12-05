require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Server do
  context 'when adding a new server' do
    connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'

    it 'a name is required' do
      #netscaler.adapter = Netscaler::MockAdapter.new :status_code=>400, :body => '{ "errorcode": 1095, "message": "Required argument missing [name]", "severity": "ERROR" }',

      expect {
        connection.servers.add_server({'ipaddress'=>'123.123.123.123'})
      }.should raise_error(ArgumentError, /name/)
    end

    it 'a ipaddress is required' do
      expect {
        connection.servers.add_server({'name'=>'hostname'})
      }.should raise_error(ArgumentError, /ipaddress/)
    end
  end
end
