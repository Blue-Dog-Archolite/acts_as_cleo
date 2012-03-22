# Table fields for 'electronics'
# - id
# - name
# - manufacturer
# - features
# - category
# - price

class Electronic < ActiveRecord::Base
  acts_as_cleo
end
