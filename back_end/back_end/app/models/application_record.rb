class ApplicationRecord < ActiveRecord::Base
  cattr_accessor :current_user_id
  primary_abstract_class
end
