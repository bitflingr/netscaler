require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Lb::Monitor do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  %w(add remove).each do |toggle_action|
    context "when #{toggle_action}ing a lbmonitor" do
      it 'a monitorName is required' do
        expect {
          connection.lb.monitor.send(toggle_action, {:type => 'HTTP'})
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'a type is required' do
        expect {
          connection.lb.monitor.send(toggle_action, {:monitorName => 'foo'})
        }.to raise_error(ArgumentError, /type/)
      end

      it 'return hash when supplied all required params' do
        result = connection.lb.monitor.send(toggle_action, {:monitorName => 'foo', :type => 'HTTP'})
        expect(result).to be_kind_of(Hash)
      end
    end
  end

  %w(bind unbind).each do |toggle_action|
    context "when #{toggle_action}ing a lbmonitor" do
      it 'a monitorName is required' do
        expect {
          connection.lb.monitor.send(toggle_action, {:type => 'HTTP'})
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'a entityName is required' do
        expect {
          connection.lb.monitor.send(toggle_action, {:entityName => 'HTTP'})
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'a monitorName is required' do
        expect {
          connection.lb.monitor.send(toggle_action, {:entityType => 'HTTP'})
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'a entityType only accepts service[group] as acceptable values' do
        expect {
          connection.lb.monitor.send(toggle_action, {:monitorName => 'foo', :entityName => 'bar', :entityType => 'HTTP'})
        }.to raise_error(ArgumentError, /entityType/)
      end

      it 'a returns when supplied all required params' do
        expect(
               connection.lb.monitor.send(toggle_action, {
                 :monitorName => 'foo',
                 :entityName => 'bar',
                 :entityType => 'service'})
               ).to be_kind_of(Hash)
      end
    end

    context 'when showing a lbmonitor' do
      it 'a monitorName is required' do
        expect {
          connection.lb.monitor.show :blah => 'foo'
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'return hash when supplied all required params' do
        result = connection.lb.monitor.show :monitorName => 'foo'
        expect(result).to be_kind_of(Hash)
      end
    end

    context 'when showing bindings of a lbmonitor' do
      it 'a monitorName is required' do
        expect {
          connection.lb.monitor.show_binding :entityType => 'foo'
        }.to raise_error(ArgumentError, /monitorName/)
      end

      it 'a entityType is required' do
        expect {
          connection.lb.monitor.show_binding :monitorName => 'HTTP'
        }.to raise_error(ArgumentError, /entityType/)
      end

      it 'returns error if entityType does not equal service or servicegroup' do
        expect{connection.lb.monitor.show_binding :monitorName => 'foo', :entityType => 'HTTP'}.to raise_error(ArgumentError, /entityType/)
      end

      it 'return hash when supplied all required params' do
        result = connection.lb.monitor.show_binding :monitorName => 'foo', :entityType => 'service'
        expect(result).to be_kind_of(Hash)
      end

    end

  end
end

