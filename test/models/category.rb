class Category < ActiveRecord::Base
  acts_as_cleo_connection :origin => "book", :target => "author", :type => "call_for_type_method"

  belongs_to :book
  belongs_to :author
end
