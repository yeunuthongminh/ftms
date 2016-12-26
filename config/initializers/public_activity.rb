PublicActivity::Activity.class_eval do
  include OrderScope
  scope :user_activities, ->user_id{where "owner_id = ?", user_id}
  scope :course_activities, ->course_id{where "recipient_id = ?", course_id}
  scope :subject_activities, ->course_subject_id{where "recipient_id = ?", course_subject_id}
end
