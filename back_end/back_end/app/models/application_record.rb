class ApplicationRecord < ActiveRecord::Base
  cattr_accessor :current_user
  primary_abstract_class
end
