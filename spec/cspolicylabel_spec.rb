require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Server do
  connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when showing a cspolicylabel' do
    it 'a name is required' do
      expect {
        connection.cs.policylabel.show(:badname => 'foo')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'returns a Hash object if no args are passed' do
      result = connection.cs.policylabel.show
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when showing a cspolicylabel bindings' do
    it 'a name is required' do
      expect {
        connection.cs.policylabel.show_binding
      }.to raise_error(ArgumentError, /wrong number/)
    end

  end

end
