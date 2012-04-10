require 'simplecov'
SimpleCov.start

require 'rails'
require 'resque'
require 'rubygems'
require 'bundler'
require 'active_record'
require 'net/http'


#load Cleo Module for result and server
require File.dirname(__FILE__) + '/../lib/cleo/cleo'

#require acts_as_cleo
require File.dirname(__FILE__) + '/../lib/acts_as_cleo/acts_as_cleo'
#require File.dirname(__FILE__) + '/../lib/acts_as_cleo_connection'

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

#Load Database Cleaner
require 'database_cleaner'
DatabaseCleaner[:active_record].strategy = :truncation

# Load Models
models_dir = File.join(file_dirname, 'models')
Dir[ models_dir + '/*.rb'].each { |m| require m }

server_config = {:url => "http://localhost:8080/cleo-primer/", :run_async => false}
Cleo.configure server_config

class Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean
  end

  def teardown
    Book.destroy_all
    Movie.destroy_all
  end
end
