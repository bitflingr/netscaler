require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Lb::Monitor do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when .show a ha.node' do
    it 'a id is required' do
      expect {
        connection.ha.node.show :id => nil
      }.to raise_error(ArgumentError, /id/)
    end

    it 'returns a Hash object if all necessary args are supplied.' do
      expect(
        connection.ha.node.show(:id => 'foo_80')
      ).to be_kind_of(Hash)
    end

    it 'returns a Hash object if 0 args are supplied' do
      expect(
        connection.ha.node.show
      ).to be_kind_of(Hash)
    end
  end

  context 'when .stat a ha.node' do
    it 'returns a Hash object if 0 args are supplied' do
      expect(
        connection.ha.node.stat
      ).to be_kind_of(Hash)
    end

  end
end
