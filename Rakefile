# encoding: utf-8

require 'rubygems'
require 'rake'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "acts_as_cleo"
  gem.homepage = "http://github.com/blue-dog-archolite/acts_as_cleo"
  gem.license = "MIT"
  gem.summary = %Q{A Rails enabled Cleo API}
  gem.description = %Q{LinkedIn Open Source type ahead tool's REST API as a ruby gem. Now with Reddis support.}
  gem.email = "Blue.Dog.Archolite@gmail.com"
  gem.authors = ["Robert R. Meyer"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  puts "*" * 100
  puts "WARNING CURRENTLY SLECTING ONLY _test.rb FILES FOR TESTING"
  puts "*" * 100
  puts "Should select test_*.rb and rename other files to match"
  puts "*" * 100
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_cleo #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
