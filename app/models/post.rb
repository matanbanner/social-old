class Post < ApplicationRecord
  belongs_to :publisher, class_name: 'User'
  belongs_to :shared, class_name: 'Post', optional: true # the post maybe a shared post of other post
  has_many :comments, dependent: :destroy










  def self.populate_with_faker
    User.all.each do |user|
      n = rand(0..10)
      title = Faker::Hipster.sentence(3)
      body = Faker::Hipster.sentence
      created_at = Faker::Time.between(1.years.ago, 1.week.ago)
      updated_at = created_at + rand(0..100).hours
      n.times do
        user.posts.create(title: title, body: body, created_at: created_at, updated_at: updated_at)
      end
    end
  end

end
