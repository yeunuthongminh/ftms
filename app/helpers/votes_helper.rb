module VotesHelper
  def vote_form type, target
    vote = if current_user && current_user.send("voted_#{type}_on?", target)
      Vote.find_by voter: current_user, votable: target
    end
    vote ||= Vote.new
    btn_class = "btn button-vote " + (vote.new_record? ? "" : type)
    btn_class += "cannot-vote" unless current_user
    form_method = vote.new_record? ? "post" : "delete"
    form_for [target, vote], html: {method: form_method,
      class: "form-vote"}, remote: true do |f|
        hidden_field = f.hidden_field :type, value: "#{type}vote"
        button = f.button type: :submit, class: btn_class do
          "<i class=\"fa fa-chevron-circle-#{type} vote-#{type}\"></i>"
            .html_safe
        end
        count = "<span class=\"badge\">#{target.send("get_#{type}votes").size}</span>"
          .html_safe
        hidden_field + button + count
    end
  end
end
