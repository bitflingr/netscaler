require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Cs::Vserver do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new ssl vserver' do
    it 'a name is required' do
      expect {
        connection.ssl.vserver.add(:serviceType => 'SSL', :port => '443', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'a service type is required' do
      expect {
        connection.ssl.vserver.add(:name => 'foo', :port => '443', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /serviceType/)
    end

    it 'a port is required' do
      expect {
        connection.ssl.vserver.add(:name => 'foo', :serviceType => 'SSL', :ipv46 => '1.1.1.1')
      }.to raise_error(ArgumentError, /port/)
    end

    it 'a ipv46 is required' do
      expect {
        connection.ssl.vserver.add(:name => 'foo', :serviceType => 'SSL', :port => '443')
      }.to raise_error(ArgumentError, /ipv46/)
    end

    it 'return hash when supplied all required params' do
      result = connection.ssl.vserver.add(:name => 'foo', :serviceType => 'SSL', :port => '443', :ipv46 => '1.1.1.1')
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when using the show method in Ssl::Vserver' do
    it 'with no param used it will return all vservers' do
      result = connection.ssl.vserver.show
      expect(result).to be_kind_of(Hash)
    end

    it 'supplying the name parameter will return Hash' do
      result = connection.ssl.vserver.show :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end

    it 'when showing a particular lb vserver string is invalid' do
      expect {
        connection.ssl.vserver.show('asdf')
      }.to raise_error(TypeError, /conver(t|sion)/)
    end

    it 'when showing a particular ssl vserver :name is required' do
      expect {
        connection.ssl.vserver.show(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end
  end

  context 'when removing an ssl vserver' do
    it 'a name is required' do
      expect {
        connection.ssl.vserver.remove()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.ssl.vserver.remove(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.ssl.vserver.remove :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when upding an ssl vserver' do
    it 'a vservername is required' do
      expect {
        connection.ssl.vserver.update()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'should return a hash if :vservername is supplied' do
      result = connection.ssl.vserver.update(
        :vservername => 'foo',
        :ssl11 => 'DISABLED',
        :ssl12 => 'DISABLED',

      )
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when showing ssl vserver bindings' do
    it 'should throw an error if there is no arg' do
      expect {
        connection.ssl.vserver.show_binding()
      }.to raise_error(ArgumentError, /wrong number/)
    end

    it 'throw an arg error if :name arg is missing' do
      expect {
        connection.ssl.vserver.show_binding(:foo => 'bar')
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a hash if :name is supplied' do
      result = connection.ssl.vserver.show_binding :name => 'foo'
      expect(result).to be_kind_of(Hash)
    end
  end

  context 'when [un]binding certificate to ssl vserver' do
    it 'should throw an error if :sslcertkey arg is not given' do
      expect {
        connection.ssl.vserver.bind.sslcertkey :name => 'foo'
      }.to raise_error(ArgumentError, /name/)
      expect {
        connection.ssl.vserver.unbind.sslcertkey :name => 'foo'
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should throw an error if :name arg is not given' do
      expect {
        connection.ssl.vserver.bind.sslcertkey :sslcertkey => 'foo'
      }.to raise_error(ArgumentError, /name/)
      expect {
        connection.ssl.vserver.unbind.sslcertkey :sslcertkey => 'foo'
      }.to raise_error(ArgumentError, /name/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.ssl.vserver.bind.sslcertkey :certkeyname => 'foo', :vservername => 'bar'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.ssl.vserver.unbind.sslcertkey :certkeyname => 'foo', :vservername => 'bar'
      expect(unbind_result).to be_kind_of(Hash)

    end
  end

  context 'when [un]binding certificate policy to ssl vserver' do
    it 'should throw an error if :vservername arg is not given' do
      expect {
        connection.ssl.vserver.bind.sslpolicy :policyname => 'foo'
      }.to raise_error(ArgumentError, /vservername/)
      expect {
        connection.ssl.vserver.unbind.sslpolicy :policyname => 'foo'
      }.to raise_error(ArgumentError, /vservername/)
    end

    it 'should throw an error if :policyname arg is not given' do
      expect {
        connection.ssl.vserver.bind.sslpolicy :vservername => 'foo'
      }.to raise_error(ArgumentError, /policyname/)
      expect {
        connection.ssl.vserver.unbind.sslpolicy :vservername => 'foo'
      }.to raise_error(ArgumentError, /policyname/)
    end

    it 'should throw an error if :priority arg is not given' do
      expect {
        connection.ssl.vserver.bind.sslpolicy :vservername => 'foo'
      }.to raise_error(ArgumentError, /priority/)
      expect {
        connection.ssl.vserver.unbind.sslpolicy :vservername => 'foo'
      }.to raise_error(ArgumentError, /priority/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.ssl.vserver.bind.sslpolicy :vservername => 'foo', :policyname => 'bar', :priority => 10
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.ssl.vserver.unbind.sslpolicy :vservername => 'foo', :policyname => 'bar', :priority => 10
      expect(unbind_result).to be_kind_of(Hash)

    end
  end

  context 'when [un]binding ecccurve to ssl vserver' do
    it 'should throw an error if :vservername arg is not given' do
      expect {
        connection.ssl.vserver.bind.ecccurve :ecccurvename => 'foo'
      }.to raise_error(ArgumentError, /vservername/)
      expect {
        connection.ssl.vserver.unbind.ecccurve :policyname => 'foo'
      }.to raise_error(ArgumentError, /vservername/)
    end

    it 'should throw an error if :ecccurvename arg is not given' do
      expect {
        connection.ssl.vserver.bind.ecccurve :vservername => 'foo'
      }.to raise_error(ArgumentError, /ecccurvename/)
      expect {
        connection.ssl.vserver.unbind.ecccurve :vservername => 'foo'
      }.to raise_error(ArgumentError, /ecccurvename/)
    end

    it 'should return a Hash if all require arguments are supplied' do
      result = connection.ssl.vserver.bind.ecccurve :vservername => 'foo', :ecccurvename => 'bar'
      expect(result).to be_kind_of(Hash)
      unbind_result = connection.ssl.vserver.unbind.ecccurve :vservername => 'foo', :ecccurvename => 'bar'
      expect(unbind_result).to be_kind_of(Hash)

    end
  end

end
