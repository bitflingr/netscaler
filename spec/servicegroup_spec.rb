require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::ServiceGroup do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new servicegroup' do
    it 'a name is required' do
      expect {
        connection.servicegroups.add({ 'serviceType' => 'tcp' })
      }.to raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a service type is required' do
      expect {
        connection.servicegroups.add({ 'serviceGroupName' => 'test-serviceGroup' })
      }.to raise_error(ArgumentError, /serviceType/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servicegroups.add :serviceGroupName => 'foo', 'serviceType' => 'bar'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when removing a servicegroup' do
    it 'has to require a serviceGroupName' do
      expect {
        connection.servicegroups.remove()
      }.to raise_error(ArgumentError, /wrong number of arguments/)
      expect {
        connection.servicegroups.remove(:foo => 'bar')
      }.to raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servicegroups.remove :serviceGroupName => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end


  context 'when binding a new server to servicegroup' do
    it 'a Service group name is required' do
      expect {
        connection.servicegroups.bind({ 'port'=> '8080', 'ip' => '199.199.199.199' })
      }.to raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a server entity is required' do
      expect {
        connection.servicegroups.bind({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
      }.to raise_error(ArgumentError, /serverName/)
    end

    it 'a port is required' do
      expect {
        connection.servicegroups.bind({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
      }.to raise_error(ArgumentError, /port/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servicegroups.bind :serviceGroupName => 'foo', :port => '80', :serverName => 'foo_80'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when unbinding a server from servicegroup' do
    it 'a Service group name is required' do
      expect {
        connection.servicegroups.unbind({ 'port' => '8080', 'ip' => '199.199.199.199' })
      }.to raise_error(ArgumentError, /serviceGroupName/)
    end

    it 'a server entity is required' do
      expect {
        connection.servicegroups.unbind({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
      }.to raise_error(ArgumentError, /serverName/)
    end

    it 'a port is required' do
      expect {
        connection.servicegroups.unbind({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
      }.to raise_error(ArgumentError, /port/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.servicegroups.unbind :serviceGroupName => 'foo', :port => '80', :serverName => 'foo_80'
      expect(result).to be_kind_of(Hash)
    end
  end

  %w(enable disable).each do |toggle_action|
    context "when running servicegroup.#{toggle_action}" do
      it ':serviceGroupName is required' do
        expect {
          connection.servicegroups.send(toggle_action, {})
        }.to raise_error(ArgumentError, /serviceGroupName/)
      end

      it 'returns a hash if all necesssary args are supplied' do
        result = connection.servicegroups.send(toggle_action, :serviceGroupName => 'foo')
        expect(result).to be_kind_of(Hash)
      end
    end

    context "when #{toggle_action} a server in servicegroup" do
      it ':serviceGroupName is required' do
        expect {
          connection.servicegroups.send("#{toggle_action}_server", {:serverName => 'foo', :port => '80'})
        }.to raise_error(ArgumentError, /serviceGroupName/)
      end

      it ':serviceGroupName is required' do
        expect {
          connection.servicegroups.send("#{toggle_action}_server", {:serviceGroupName => 'foo', :port => '80'})
        }.to raise_error(ArgumentError, /serverName/)
      end

      it ':serviceGroupName is required' do
        expect {
          connection.servicegroups.send("#{toggle_action}_server", {:serviceGroupName => 'bar', :serverName => 'foo'})
        }.to raise_error(ArgumentError, /port/)
      end

      it 'should return a Hash if all args are returned' do
        result = connection.servicegroups.send("#{toggle_action}_server", {:serviceGroupName => 'bar', :serverName => 'foo', :port => '80'})
        expect(result).to be_kind_of(Hash)
      end
    end


  end

end
