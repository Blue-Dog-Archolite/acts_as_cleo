# Table fields for 'movies'
# - id
# - name
# - description

class Movie < ActiveRecord::Base
  acts_as_cleo :score => "id", :name => "name"
end
