class User < ApplicationRecord
  attr_accessor :password, :password_confirmation
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, confirmation: true, presence: true

  before_save :encrypt_password
  after_save :clear_password

  has_attached_file :image, styles: { medium: "160x160#", thumb: "50x50#" }, default_url: "missing/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :user_follows, foreign_key: :from_user_id, dependent: :destroy
  has_many :followings, through: :user_follows, foreign_key: :from_user_id

  has_many :user_followings, class_name: 'UserFollow', foreign_key: :to_user_id, dependent: :destroy
  has_many :followers, through: :user_followings, foreign_key: :to_user_id

  has_many :posts, foreign_key: :publisher_id, dependent: :destroy


  def follow(user_or_id)
    to_user_id = user_or_id.is_a?(User) ? user_or_id.id : user_or_id
    UserFollow.create(from_user_id: self.id, to_user_id: to_user_id) if self.id != to_user_id
  end

  def unfollow(user_or_id)
    to_user_id = user_or_id.is_a?(User) ? user_or_id.id : user_or_id
    records = UserFollow.where(from_user_id: self.id, to_user_id: to_user_id).destroy_all  if self.id != to_user_id
  end

  def following?(user_or_id)
    to_user_id = user_or_id.is_a?(User) ? user_or_id.id : user_or_id
    UserFollow.where(from_user_id: self.id, to_user_id: to_user_id).present?
  end

  def post(title, body)
    self.posts.create(title: title, body: body)
  end


  def followings_posts
    posts=[]
    followings = self.followings.includes(:posts)
    followings.each{|following| posts += following.posts}
    posts.sort_by!{|post| post.created_at}
    posts
  end









  def self.authenticate(login_email="", login_password="")
    puts "login_email=#{login_email}"
    puts "login_password=#{login_password}"
    user = User.find_by(email: login_email)
    if user && user.match_password(login_password)
      return user
    else
      return nil
    end
  end


  def match_password(login_password="")
    encrypted_password == login_password
  end


  def encrypt_password
    if password.present?
      self.encrypted_password = password
    end
  end

  def clear_password
    self.password = nil
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
