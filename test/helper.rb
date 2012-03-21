require 'simplecov'
SimpleCov.start

require 'rails'
require 'rubygems'
require 'bundler'
require 'active_record'
require 'net/http'

#require acts_as_cleo
require File.dirname(__FILE__) + '/../lib/acts_as_cleo'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

file_dirname = File.dirname(__FILE__)

#Load Lib
$LOAD_PATH.unshift(File.join(file_dirname, '..', 'lib'))
$LOAD_PATH.unshift file_dirname

#Load sqlilte for testing
sqlite = File.join(file_dirname, 'db', 'connection', 'sqlite')
require sqlite

# Load Models
models_dir = File.join(file_dirname, 'models')
Dir[ models_dir + '/*.rb'].each { |m| require m }

class Test::Unit::TestCase
end
