class UserFollow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :from_user_id
  belongs_to :following, class_name: 'User', foreign_key: :to_user_id

end
