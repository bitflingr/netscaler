require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::System::File do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new certkey' do
    it 'a certkey is required' do
      expect {
        connection.ssl.certkey.add(cert: 'crt', key: 'key')
      }.to raise_error(ArgumentError, /certkey/)
    end

    it 'a cert is required' do
      expect {
        connection.ssl.certkey.add(certKey: 'name', key: 'key')
      }.to raise_error(ArgumentError, /certkey/)
    end

    it 'a key is required' do
      expect {
        connection.ssl.certkey.add(certkey: 'name', cert: 'crt')
      }.to raise_error(ArgumentError, /key/)
    end

    it 'return hash when supplied all required params' do
      result = connection.ssl.certkey.add(certkey: 'name', cert: 'crt', key: 'key')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when removing a certkey' do
    it 'a certkey is required' do
      expect {
        connection.ssl.certkey.remove :foo => 'bar'
      }.to raise_error(ArgumentError, /certkey/)
    end

    it 'return hash when supplied all required params' do
      result = connection.ssl.certkey.remove :certkey => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end
end
