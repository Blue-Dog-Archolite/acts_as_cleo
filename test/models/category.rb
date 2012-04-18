class Category < ActiveRecord::Base
  acts_as_cleo_connection :origin => "book", :target => "author", :type => "call_for_type_method"

  belongs_to :book
  belongs_to :author

  def call_for_type_method(name_return = false)
    return "InThisCase#{self.class.name}"
  end
end
