module UsersHelper
  def user_name_link(user)
    link_to user.name, user_url(user)
  end

  def user_image_link(user)
    link_to image_tag(user.image(:thumb)), user_path(user)
  end





end
