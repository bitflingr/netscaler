# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = 'netscaler'
  gem.homepage = 'http://github.com/GravityLabs/netscaler'
  gem.license = 'MIT'
  gem.summary = 'Netscaler api working against the Citrix Nitro api.'
  gem.description = 'Netscaler api working against the Citrix Nitro api.  Currently supports Nitro 9.3.  Hope to add support for 10.X.  Currently has support for som basics such as adding servers/services/servicegroups.'
  gem.email = %w(jeremy@scarcemedia.com david.andrew@webtrends.com jarrett.irons@gmail.com)
  gem.authors = ['Jeremy Custenborder', 'David Andrew', 'Jarrett Irons']
  #gem.add_dependency 'json'
  #gem.add_dependency 'rest-client'
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

# RSpec::Core::RakeTask.new(:rcov) do |spec|
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "netscaler #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

CLOBBER.include('coverage')