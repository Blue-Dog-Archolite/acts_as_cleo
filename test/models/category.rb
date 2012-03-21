# Table fields for 'categories'
# - id
# - name

class Category < ActiveRecord::Base
  has_many :books
end
