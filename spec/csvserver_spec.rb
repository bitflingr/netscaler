require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Cs::Vserver do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new csvserver' do
    it 'a name is required' do
      expect {
        connection.cs.vserver.add(:serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'a service type is required' do
      expect {
        connection.cs.vserver.add(:name => 'foo', :port => '80', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.cs.vserver.add(:name => 'foo', :serviceType => 'HTTP', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /port/)
    end

    it 'a ipv46 is required' do
      expect {
        connection.cs.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80')
      }.to raise_error(ArgumentError, /ipv46/)
    end

    it 'return hash when supplied all required params' do
      result = connection.cs.vserver.add(:name => 'foo', :serviceType => 'HTTP', :port => '80', :ipv46 => '1.1.1.1')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when using the show method in Cs::Vserver' do
    it 'with no param used it will return all vservers' do
      result = connection.cs.vserver.show
      expect(result).to be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.cs.vserver.show :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end

    it 'when showing a particular lb vserver string is invalid' do
      expect {
        connection.cs.vserver.show('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular lb vserver :name is required' do
      expect {
        connection.cs.vserver.show(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end
  end

  context 'when removing an lb vserver' do
    it 'a name is required' do
      expect {
        connection.cs.vserver.remove()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.cs.vserver.remove(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.cs.vserver.remove :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when showing csvserver bindings' do
    it 'should throw an error if there is no arg' do
      expect {
        connection.cs.vserver.show_binding()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.cs.vserver.show_binding(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.cs.vserver.show_binding :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when [un]binding lb vservers to cs vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.cs.vserver.bind.cs_policy :serviceName => 'foo'
      }.to raise_error(ArgumentError, /name/)
      expect {
        connection.cs.vserver.unbind.cs_policy :serviceName => 'foo'
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should throw an error if :targetvserver arg is not given' do
      expect {
        connection.cs.vserver.bind.cs_policy :name => 'foo'
      }.to raise_error(ArgumentError, /targetvserver/)

      #This is actually not expected when unbinding.
      # expect {
      #   connection.cs.vserver.unbind.cs_policy :name => 'foo'
      # }.to raise_error(ArgumentError, /targetvserver/)

    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.cs.vserver.bind.cs_policy :name => 'foo', :targetvserver => 'bar'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.cs.vserver.unbind.cs_policy :name => 'foo'
      expect(unbind_result).to be_kind_of(Hash)

    end
  end

  context 'when [un]binding rewritepolicies to cs vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.cs.vserver.bind.rewrite_policy :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /name/)

      expect {
        connection.cs.vserver.unbind.rewrite_policy :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /name/)

    end

    it 'should throw an error if :policyName arg is not given' do
      expect {
        connection.cs.vserver.bind.rewrite_policy :name => 'foo', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /policyName/)

      expect {
        connection.cs.vserver.unbind.rewrite_policy :name => 'foo', :priority => '10', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /policyName/)
    end

    it 'should throw an error if :priority arg is not given' do
      expect {
        connection.cs.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :bindpoint => 'request'
      }.to raise_error(ArgumentError, /priority/)
    end

    it 'should throw an error if :bindpoint arg is not given' do
      expect {
        connection.cs.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /bindpoint/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.cs.vserver.bind.rewrite_policy :name => 'foo', :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.cs.vserver.unbind.rewrite_policy :name => 'foo', :policyName => 'bar'
      expect(unbind_result).to be_kind_of(Hash)
    end
  end

  context 'when [un]binding responderpolicies to cs vserver' do
    it 'should throw an error if :name arg is not given' do
      expect {
        connection.cs.vserver.bind.responder_policy :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /name/)

      expect {
        connection.cs.vserver.unbind.responder_policy :policyName => 'bar', :priority => '10'
      }.to raise_error(ArgumentError, /name/)

    end

    it 'should throw an error if :policyName arg is not given' do
      expect {
        connection.cs.vserver.bind.responder_policy :name => 'foo', :priority => '10'
      }.to raise_error(ArgumentError, /policyName/)

      expect {
        connection.cs.vserver.unbind.responder_policy :name => 'foo', :priority => '10'
      }.to raise_error(ArgumentError, /policyName/)
    end

    it 'should throw an error if :priority arg is not given' do
      expect {
        connection.cs.vserver.bind.responder_policy :name => 'foo', :policyName => 'bar'
      }.to raise_error(ArgumentError, /priority/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.cs.vserver.bind.responder_policy :name => 'foo', :policyName => 'bar', :priority => '10', :bindpoint => 'request'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.cs.vserver.unbind.responder_policy :name => 'foo', :policyName => 'bar'
      expect(unbind_result).to be_kind_of(Hash)
    end
  end

end
