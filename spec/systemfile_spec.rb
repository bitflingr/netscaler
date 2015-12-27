require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'netscaler'
require 'netscaler/mock_adapter'

describe Netscaler::System::File do

  connection = Netscaler::Connection.new 'hostname' => 'foo', 'password' => 'bar', 'username' => 'bar'
  connection.adapter = Netscaler::MockAdapter.new :body => '{ "errorcode": 0, "message": "Done" }'

  context 'when adding a new file' do
    it 'a filename is required' do
      expect {
        connection.system.file.add(filecontent: 'content', filelocation: '/nsconf/ssl')
      }.to raise_error(ArgumentError, /filename/)
    end

    it 'a filecontent is required' do
      expect {
        connection.system.file.add(filename: 'name', filelocation: '/nsconf/ssl')
      }.to raise_error(ArgumentError, /filecontent/)
    end

    it 'a filelocation is required' do
      expect {
        connection.system.file.add(filename: 'name', filecontent: 'contet')
      }.to raise_error(ArgumentError, /filelocation/)
    end

    it 'return hash when supplied all required params' do
      result = connection.system.file.add(filename: 'name', filecontent: 'contet', filelocation: '/nsconf/ssl')
      expect(result).to be_kind_of(Hash)
    end
  end
end
