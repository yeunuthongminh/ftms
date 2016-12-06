module WickedHelper

  def avatar_user_pdf user, class_name, avatar_size
    wicked_pdf_image_tag user.avatar_url ? user.avatar_url : "profile.png",{
      class: class_name.to_sym, size: avatar_size}
  end
end
