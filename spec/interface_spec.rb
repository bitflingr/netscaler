require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::Lb::Monitor do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  %w(stat show).each do |toggle_action|
    context "when #{toggle_action}ing a interface" do
      it 'return hash when name is not supplied' do
        expect(
          connection.system.interface.send(toggle_action)
               ).to be_kind_of(Hash)
      end


      it 'return hash when supplied all required params' do
        result = connection.system.interface.send(toggle_action, {:name => 'foo'})
        expect(result).to be_kind_of(Hash)
      end
    end
  end
end

