require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Rewrite::Action do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when using the show method in Rewrite::Action' do
    it 'with no param used it will return all rewrite actions' do
      result = connection.rewrite.action.show
      result.should be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.rewrite.action.show :name => 'foo'
      result.should be_kind_of(Hash)
    end

    it 'when showing a particular rewrite action, string is invalid' do
      expect {
        connection.rewrite.action.show('asdf')
      }.should raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular rewrite action :name is required' do
      expect {
        connection.rewrite.action.show(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end
  end
end

describe Netscaler::Rewrite::Policy do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when using the show method in Rewrite::Policy' do
    it 'with no param used it will return all rewrite policies' do
      result = connection.rewrite.policy.show
      result.should be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.rewrite.policy.show :name => 'foo'
      result.should be_kind_of(Hash)
    end

    it 'when showing a particular rewrite policy, string is invalid' do
      expect {
        connection.rewrite.policy.show('asdf')
      }.should raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular rewrite policy :name is required' do
      expect {
        connection.rewrite.policy.show(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end
  end
end
