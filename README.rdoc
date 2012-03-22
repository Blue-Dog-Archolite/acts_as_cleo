= acts_as_cleo

=== To enable

Create a cleo.yml in your config directory.

  development:

    url: "http://localhost:8080/cleo-primer/"

  production:

    url: "http://localhost:8080/cleo-primer/"


=== Usage


  Cleo.find(int)              # Find Cleo entry by Cleo native id

  Cleo.update(Cleo::Result)   # Pass any acts_as_cleo object to this method to have it update the Cleo entry

  Cleo.delete(int)            # Delete by Cleo id, also accepts any acts_as_cleo object or Cleo::Result

  Cleo.create(obj)            # Creates new entry on Cleo index. Accepts any acts_as_cleo object or Cleo::Result

  Cleo.query(string)          # Takes string search param and returns array of Cleo::Reference objects



To enable on an ActiveRecord::Base model:

  acts_as_cleo

  acts_as_cleo :terms => %w{terms to be stored}

  acts_as_cleo :except => %w{columns to be ignored}

  acts_as_cleo :score=> "method or column to be used"

  acts_as_cleo :terms => %w{name value other}, :score => "my_score_method"

Default functionality takes all column_names and uses them as terms for Cleo search.

To specify terms to be stored in Cleo, pass :terms => [] with the column and/or method names to be stored

acts_as_cleo ignores updated_at, created_at, id by default.

You can specify more columns to ignore by passing :except => [] with column names.

By default, acts_as_cleo uses the column "name" from your model as the Cleo search name. To specify the name in Cleo, pass :name => "my_attribute_name"

To specify a Cleo score, pass :score => "name of column or function"

ActiveRecord::Base objects with acts_as_cleo get three callback functions:

set_cleo_id, sync_with_cleo and remove_from_cleo

= WARNING

This gem is still in beta. 

* Cleo.find
* Cleo.update
* Cleo.delete
* Cleo.create

As of this moment you need to pass a constructed Cleo::Result object to the above methods for them to function correctly.

Feel free to use this gem and provide feedback / patch requests.

Acts As Cleo is a Rails gem that allows for easy integration with Linked In's Open Source type ahead manager.

Verify that you have downloaded and installed cleo locally.

== Contributing to acts_as_cleo

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== To test
* verify that cleo is running locally.
* rake

== Copyright

Copyright (c) 2012 Robert R. Meyer. See LICENSE.txt for
further details.
