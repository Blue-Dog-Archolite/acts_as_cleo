class Category < ActiveRecord::Base
  acts_as_cleo_connection :origin => "book", :target => "author", :type => "isaidso"

  belongs_to :book
  belongs_to :author
end
