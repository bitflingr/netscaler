require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler do
  context 'creating a new instance' do
    it 'a hostname is required' do
      expect {
        netscaler = Netscaler::Connection.new 'username'=> 'foo', 'password' => 'bar'
      }.should raise_error(ArgumentError, /hostname/)
    end
    it 'a username is required' do
      expect {
        netscaler = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar'
      }.should raise_error(ArgumentError, /username/)
    end
    it 'a password is required' do
      expect {
        netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar'
      }.should raise_error(ArgumentError, /password/)
    end
  end

  context 'when logging in' do
    it 'returns a session' do
      netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar', 'password' => 'asdf'
      netscaler.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done", "sessionid": "##074E17E8CD4C9E95A206C2A5E543D82BCDA57F16A7BE74F985733D6C241B" }'
      result = netscaler.login
      result.should be_a_kind_of(String)
      result.should == "##074E17E8CD4C9E95A206C2A5E543D82BCDA57F16A7BE74F985733D6C241B"
    end
  end
end
