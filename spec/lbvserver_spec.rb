require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Lb::Vserver do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new lbvserver' do
    it 'a name is required' do
      expect {
        connection.lb.vserver.add(:serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'a service type is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :port => '80', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /port/)
    end

    it 'a ipv46 is required' do
      expect {
        connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /ipv46/)
    end

    it 'return hash when supplied all required params' do
      result = connection.lb.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when show|stat method in Lb::Vserver' do
    it 'with no param used it will return all vservers' do
      expect(connection.lb.vserver.show).to be_kind_of(Hash)
      expect(connection.lb.vserver.stat).to be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      expect(connection.lb.vserver.show :name => 'foo').to be_kind_of(Hash)
      expect(connection.lb.vserver.stat :name => 'foo').to be_kind_of(Hash)
    end

    it 'when showing a particular lb vserver string is invalid' do
      expect {
        connection.lb.vserver.show('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)

      expect {
        connection.lb.vserver.stat('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)

    end

    it 'when showing a particular lb vserver :name is required' do
      expect {
        connection.lb.vserver.show(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
      #This should be updated to match the show method.
      expect {
        connection.lb.vserver.stat(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)

    end
  end

  context 'when removing an lb vserver' do
    it 'a name is required' do
      expect {
        connection.lb.vserver.remove()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.lb.vserver.remove(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.lb.vserver.remove :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when show lbvserver bindings' do
    it 'should throw an error if there is no arg' do
      expect {
        connection.lb.vserver.show_binding()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.lb.vserver.show_binding(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.lb.vserver.show_binding :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when [un]binding services to lb vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.lb.vserver.bind.service :serviceName => 'foo'
      }.to raise_error(ArgumentError, /name/)
      expect {
        connection.lb.vserver.unbind.service :serviceName => 'foo'
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should throw an error if :serviceName arg is not given' do
      expect {
        connection.lb.vserver.bind.service :name => 'foo'
      }.to raise_error(ArgumentError, /serviceName/)

      expect {
        connection.lb.vserver.unbind.service :name => 'foo'
      }.to raise_error(ArgumentError, /serviceName/)

    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.lb.vserver.bind.service :name => 'foo', :serviceName => ''
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.lb.vserver.unbind.service :name => 'foo', :serviceName => ''
      expect(unbind_result).to be_kind_of(Hash)

    end
  end

  context 'when [un]binding rewritepolicies to lb vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.lb.vserver.bind.rewrite_policy :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /name/)

      expect {
        connection.lb.vserver.unbind.rewrite_policy :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /name/)

    end

    it 'should throw an error if :policyName arg is not given' do
      expect {
        connection.lb.vserver.bind.rewrite_policy :name => 'foo', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /policyName/)

      expect {
        connection.lb.vserver.unbind.rewrite_policy :name => 'foo', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /policyName/)
    end

    it 'should throw an error if :priority arg is not given' do
      expect {
        connection.lb.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /priority/)
    end

    it 'should throw an error if :bindpoint arg is not given' do
      expect {
        connection.lb.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /bindpoint/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.lb.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.lb.vserver.unbind.rewrite_policy :name => 'foo', :policyName => 'bar'
      expect(unbind_result).to be_kind_of(Hash)
    end
  end

  context 'when [un]binding responder policies to lb vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.lb.vserver.bind.responder_policy :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /name/)

      expect {
        connection.lb.vserver.unbind.responder_policy :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /name/)

    end

    it 'should throw an error if :policyName arg is not given' do
      expect {
        connection.lb.vserver.bind.responder_policy :name => 'foo', :priority => '10'
      }.to raise_error(ArgumentError, /policyName/)

      expect {
        connection.lb.vserver.unbind.responder_policy :name => 'foo', :priority => '10'
      }.to raise_error(ArgumentError, /policyName/)
    end

    it 'should throw an error if :priority arg is not given' do
      expect {
        connection.lb.vserver.bind.responder_policy :name => 'foo', :policyName => 'bar'
      }.to raise_error(ArgumentError, /priority/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      expect(
        connection.lb.vserver.bind.responder_policy :name => 'foo', :policyName => 'bar', :priority => '10'
      ).to be_kind_of(Hash)
      expect(
        connection.lb.vserver.unbind.responder_policy :name => 'foo', :policyName => 'bar'
      ).to be_kind_of(Hash)
    end
  end

end