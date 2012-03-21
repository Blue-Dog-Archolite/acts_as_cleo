# Table fields for 'books'
# - id
# - category_id
# - name
# - author

class Book < ActiveRecord::Base
  belongs_to :category

  acts_as_cleo :terms => %w{name author}, :score => "cleo_score", :name => "name"

  def cleo_score
    Random.rand(10...47)
  end
end
