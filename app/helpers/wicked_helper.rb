module WickedHelper

  def avatar_user_pdf user, class_name, avatar_size
    wicked_pdf_image_tag user.avatar_url ? user.avatar_url : "profile.png",{
      class: class_name.to_sym, size: avatar_size}
  end

  def set_image_pdf object, size = Settings.image_size_100, class_name = "img-circle"
    wicked_pdf_image_tag object.image_url ? object.image_url : "no_image.gif",
      size: size, class: class_name
  end
end
