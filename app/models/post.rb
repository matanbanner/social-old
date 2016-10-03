class Post < ApplicationRecord
  belongs_to :publisher, class_name: 'User'
  belongs_to :shared, class_name: 'Post', optional: true # the post maybe a shared post of other post


end
