class Author < ActiveRecord::Base
  acts_as_cleo
  has_many :categories
  has_many :books
end
