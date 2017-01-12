module SynchronizeQnA
  def synchronize_qna title
    worksheet = @file.worksheet_by_title title
    worksheet.list.each do |line|
      user = User.find_by_name line[Settings.sync.question_answers.name].strip
      unless user.present?
        user = load_admin
      end
      question = line[Settings.sync.question_answers.question].strip
      post = Post.find_by content: question
      answer = line[Settings.sync.question_answers.answer].strip
      comment = Comment.find_by content: answer
      category = line[Settings.sync.question_answers.category].strip
      title = convert_title question

      if post
        post.title ||= title
        post.content ||= question
        post.user_id ||= user.id
        post.tag_list ||= category
        unless answer.blank?
          if comment
            comment.content ||= answer
            comment.user_id ||= trainer_id
            comment.post_id ||= post.id
          else
            post.comments.build user_id: trainer_id,
              content: line[Settings.sync.question_answers.answer].strip
          end
        end
      else
        post = Post.new title: title, content: question, user_id: user.id
        unless answer.blank?
          post.comments.build user_id: trainer_id,
            content: answer
        end
        post.tag_list = category
      end

      post.try :save!
    end

  end

  private
  def trainer_id
    User.find_by(email: "nguyen.binh.dieu@framgia.com").id
  end

  def load_admin
    User.find_by email: "admin@tms.com"
  end

  def convert_title content
    title = if content.length >= 100
      content.truncate 50
    elsif content.length >= 50
      content.truncate 25
    else
      content
    end
  end
end
