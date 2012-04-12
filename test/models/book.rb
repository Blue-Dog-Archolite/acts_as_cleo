class Book < ActiveRecord::Base
  has_many :category
  belongs_to :author


  acts_as_cleo :terms => %w{name author}, :score => "cleo_score", :name => "name"

  def cleo_score
    1000
  end
end
