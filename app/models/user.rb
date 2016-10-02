class User < ApplicationRecord
  has_attached_file :image, styles: { medium: "160x160#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :user_follows, foreign_key: :from_user_id
  has_many :followings, through: :user_follows, foreign_key: :from_user_id

  has_many :user_followings, class_name: 'UserFollow', foreign_key: :to_user_id
  has_many :followers, through: :user_followings, foreign_key: :to_user_id

  def follow(user)
    UserFollow.create(from_user_id: self.id, to_user_id: user.id)
  end







# make dummy records

  def self.create_follows
    User.all.each do |user|
      followings = User.where.not(id: user.id).order("RANDOM()").take(rand(0..15))
      followings.each do |following|
        user.follow(following)
      end
    end
  end


  def self.populate_with_faker

    image_filenames = Dir.glob(File.join(Rails.root, 'sampleimages', '*'))

    users=[]

    image_filenames.each do |filename|
      name = Faker::Name.name
      email = Faker::Internet.email(name)
      country = Faker::Address.country
      birthday = Faker::Date.between(100.years.ago, 16.years.ago)
      file = open(filename)

      users << User.new(name: name, email: email, country: country, birthday: birthday, image: file)

    end

    users.each{|user| user.save}


  end
end
