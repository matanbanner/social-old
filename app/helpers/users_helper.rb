module UsersHelper
  def user_name_link(user)
    link_to user.name, user_url(user)
  end

  def user_image_tag(user, style=:thumb)
    image_tag(user.image(style))
  end

  def user_image_link(user, style=:thumb, as_link=true)
    img_tag = image_tag(user.image(style))
    if as_link
      link_to img_tag, user_path(user)
    else
      img_tag
    end
  end

end
