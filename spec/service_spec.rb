require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Service do
  connection = Netscaler::Connection.new 'hostname'=> 'foo', 'password' => 'bar', 'username'=> 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new service' do
    it 'a name is required' do
      expect {
        connection.service.add(:serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /name/)
      expect {
        connection.service.remove(:serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'a serverName is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /serverName/)
    end

    it 'a serviceType is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serverName => 'foo', :port => '80')
      }.to raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.service.add(:name => 'foo_80', :serverName => 'foo', :serviceType => 'HTTP')
      }.to raise_error(ArgumentError, /port/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.service.add(:name => 'foo_80', :serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when removing a new service' do
    it 'a name is required' do
      expect {
        connection.service.remove(:serverName => 'foo', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.service.remove(:name => 'foo_80')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when show a service' do
    it 'serviceName is required' do
      expect {
        connection.service.show(:name => 'foo')
      }.to raise_error(ArgumentError, /serviceName/)
    end

    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.service.show(:serviceName => 'foo_80')
      expect(result).to be_kind_of(Hash)
    end

    it 'returns a Hash object if 0 args are supplied' do
      result = connection.service.show
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when stat a service' do
    it 'returns a Hash object if all necessary args are supplied' do
      result = connection.service.stat(:name => 'foo_80')
      expect(result).to be_kind_of(Hash)
    end

    it 'returns a Hash object if 0 args are supplied' do
      result = connection.service.stat
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when enable|disable|show_binding a service' do
    it 'returns a Hash object if all necessary args are supplied' do
      expect(connection.service.show_binding(:name => 'foo_80')).to be_kind_of(Hash)
      expect(connection.service.enable(:name => 'foo_80')).to be_kind_of(Hash)
      expect(connection.service.disable(:name => 'foo_80')).to be_kind_of(Hash)
    end

    it 'returns an error when 0 arguments are supplied.' do
      expect {
        connection.service.show_binding
      }.to raise_error(ArgumentError, /wrong number/)
      expect {
        connection.service.enable
      }.to raise_error(ArgumentError, /wrong number/)
      expect {
        connection.service.disable
      }.to raise_error(ArgumentError, /wrong number/)

    end
  end
end
