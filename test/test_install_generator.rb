require 'helper'
require 'generators/acts_as_cleo/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  destination File.expand_path('../../tmp', __FILE__)
  setup :prepare_destination
  tests ActsAsCleo::Generators::InstallGenerator

  should "generate a migration" do
    run_generator %w(install)

    Dir['/tmp/db/migrate/*.rb'].each do |m|
      assert_migration m do |content|
        assert_match /class InstallActsAsCleo/, content
      end
    end
  end
end
