require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Responder::Action do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when using the show method in Responder::Action' do
    it 'with no param used it will return all responder actions' do
      result = connection.responder.action.show
      expect(result).to be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.responder.action.show :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end

    it 'when showing a particular responder action, string is invalid' do
      expect {
        connection.responder.action.show('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular responder action :name is required' do
      expect {
        connection.responder.action.show(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end
  end
end

describe Netscaler::Responder::Policy do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when using the show method in Responder::Policy' do
    it 'with no param used it will return all responder policies' do
      result = connection.responder.policy.show
      expect(result).to be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.responder.policy.show :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end

    it 'when showing a particular responder policy, string is invalid' do
      expect {
        connection.responder.policy.show('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular responder policy :name is required' do
      expect {
        connection.responder.policy.show(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end
  end
end
