class Post < ApplicationRecord
  belongs_to :publisher, class_name: 'User'
  belongs_to :shared, class_name: 'Post'


end
