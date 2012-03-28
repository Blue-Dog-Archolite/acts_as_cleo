require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'rails/generators/active_record'

module ActsAsCleo
  class UpdateGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../templates", __FILE__)

    def copy_migration_and_config

      #Resque workers
      %w{update create delete}.each do |life|
        delete_file "app/jobs/#{life}.rb"
      end

      #new general processor
      copy_file "jobs/cleo_processor.rb", "app/jobs/cleo_processor.rb"

      #create migration
      migration_template 'update.rb', 'db/migrate/update_acts_as_cleo.rb'
    end

    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      if ActiveRecord::Base.timestamped_migrations
        [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
      else
        "%.3d" % next_migration_number
      end
    end
  end
end
