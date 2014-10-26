require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Lb::Vserver do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new lbvserver' do
    it 'a name is required' do
      #netscaler.adapter = Netscaler::MockAdapter.new :status_code=>400, :body => '{ "errorcode": 1095, "message": "Required argument missing [name]", "severity": "ERROR" }',

      expect {
        connection.lb.vserver.add(:serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      }.should raise_error(ArgumentError, /name/)
    end

    it 'a service type is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :port => '80', :ipv46 => '1.1.1.1')
      }.should raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :ipv46 => '1.1.1.1')
      }.should raise_error(ArgumentError, /port/)
    end

    it 'a ipv46 is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80')
      }.should raise_error(ArgumentError, /ipv46/)
    end

    it 'return hash when supplied all required params' do
      result = connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      result.should be_kind_of(Hash)
    end
  end

  context 'when using the show method in Lb::Vserver' do
    it 'with no param used it will return all vservers' do
      result = connection.lb.vserver.show
      result.should be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.lb.vserver.show :name => 'foo'
      result.should be_kind_of(Hash)
    end

    it 'when showing a particular lb vserver string is invalid' do
      expect {
        connection.lb.vserver.show('asdf')
      }.should raise_error(TypeError, /convert/)
    end

    it 'when showing a particular lb vserver :name is required' do
      expect {
        connection.lb.vserver.show(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end
  end

  context 'when removing an lb vserver' do
    it 'a name is required' do
      expect {
        connection.lb.vserver.remove()
      }.should raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.lb.vserver.remove(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.lb.vserver.remove :name => 'foo'
      result.should be_kind_of(Hash)
    end
  end

  context 'when showing lbvserver bindings' do
    it 'should throw an error if there is no arg' do
      expect {
        connection.lb.vserver.show_binding()
      }.should raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.lb.vserver.show_binding(:foo => 'bar')
      }.should raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.lb.vserver.show_binding :name => 'foo'
      result.should be_kind_of(Hash)
    end

  end


  # context 'when binding a new lbmonitor to lbvserver' do
  #
  #   it 'a Service group name is required' do
  #     expect {
  #       connection.lbvservers.lbmonitor_lbvserver_binding({ 'monitorName' => 'TCP' })
  #     }.should raise_error(ArgumentError, /serviceGroupName/)
  #   end
  #
  #   it 'a lbmonitor name is required' do
  #     expect {
  #       connection.lbvservers.lbmonitor_lbvserver_binding({ 'serviceGroupName' => 'test-serviceGroup' })
  #     }.should raise_error(ArgumentError, /monitorName/)
  #   end
  #
  # end
  #
  # context 'when unbinding a lbmonitor from lbvserver' do
  #
  #   it 'a Service group name is required' do
  #     expect {
  #       connection.lbvservers.lbmonitor_lbvserver_binding({ 'monitorName' => 'TCP' })
  #     }.should raise_error(ArgumentError, /serviceGroupName/)
  #   end
  #
  #   it 'a lbmonitor name is required' do
  #     expect {
  #       connection.lbvservers.lbmonitor_lbvserver_binding({ 'serviceGroupName' => 'test-serviceGroup' })
  #     }.should raise_error(ArgumentError, /monitorName/)
  #   end
  #
  # end
  #
  # context 'when binding a new server to lbvserver' do
  #
  #   it 'a Service group name is required' do
  #     expect {
  #       connection.lbvservers.bind_lbvserver_lbvservermember({ 'port'=> '8080', 'ip' => '199.199.199.199' })
  #     }.should raise_error(ArgumentError, /serviceGroupName/)
  #   end
  #
  #   it 'a server entity is required' do
  #     expect {
  #       connection.lbvservers.bind_lbvserver_lbvservermember({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
  #     }.should raise_error(ArgumentError, /serverName/)
  #   end
  #
  #   it 'a port is required' do
  #     expect {
  #       connection.lbvservers.bind_lbvserver_lbvservermember({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
  #     }.should raise_error(ArgumentError, /port/)
  #   end
  #
  # end
  #
  # context 'when unbinding a server from lbvserver' do
  #
  #   it 'a Service group name is required' do
  #     expect {
  #       connection.lbvservers.unbind_lbvserver_lbvservermember({ 'port' => '8080', 'ip' => '199.199.199.199' })
  #     }.should raise_error(ArgumentError, /serviceGroupName/)
  #   end
  #
  #   it 'a server entity is required' do
  #     expect {
  #       connection.lbvservers.unbind_lbvserver_lbvservermember({ 'serviceGroupName' => 'test-serviceGroup', 'port' => '8080' })
  #     }.should raise_error(ArgumentError, /serverName/)
  #   end
  #
  #   it 'a port is required' do
  #     expect {
  #       connection.lbvservers.unbind_lbvserver_lbvservermember({ 'serviceGroupName' => 'test-serviceGroup', 'ip' => '199.199.199.199' })
  #     }.should raise_error(ArgumentError, /port/)
  #   end
  #
  # end

end
