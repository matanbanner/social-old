class User < ApplicationRecord
  has_attached_file :image, styles: { medium: "160x160#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/



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
