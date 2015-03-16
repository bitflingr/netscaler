require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler do
  context 'creating a new instance' do
    it 'a hostname is required' do
      expect {
        netscaler = Netscaler::Connection.new 'username'=> 'foo', 'password' => 'bar'
      }.to raise_error(ArgumentError, /hostname/)
    end
    it 'a username is required' do
      expect {
        netscaler = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar'
      }.to raise_error(ArgumentError, /username/)
    end
    it 'a password is required' do
      expect {
        netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar'
      }.to raise_error(ArgumentError, /password/)
    end
    it 'verify_ssl should be true' do
      netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar', 'password' => 'baz'
      netscaler.verify_ssl == true
    end
    context 'if setting verify_ssl to false' do
      it 'verify_ssl should be false' do
        netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar', 'password' => 'baz', 'verify_ssl' => false
        netscaler.verify_ssl == false
      end
    end
  end

  context 'when logging in' do
    it 'returns a session' do
      netscaler = Netscaler::Connection.new 'username'=> 'foo', 'hostname' => 'bar', 'password' => 'asdf'
      netscaler.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done", "sessionid": "##074E17E8CD4C9E95A206C2A5E543D82BCDA57F16A7BE74F985733D6C241B" }'
      result = netscaler.login
      expect(result).to be_a_kind_of(String)
      expect(result).to eq("##074E17E8CD4C9E95A206C2A5E543D82BCDA57F16A7BE74F985733D6C241B")
    end
  end
end
