# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170208095847) do

  create_table "course_subject_teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "team_id"
    t.integer  "course_subject_id"
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["course_subject_id"], name: "index_course_subject_teams_on_course_subject_id", using: :btree
    t.index ["team_id"], name: "index_course_subject_teams_on_team_id", using: :btree
  end

  create_table "course_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "subject_id"
    t.string   "subject_name"
    t.string   "subject_description"
    t.text     "subject_content",     limit: 65535
    t.string   "image"
    t.integer  "course_id"
    t.string   "github_link"
    t.string   "heroku_link"
    t.string   "redmine_link"
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["course_id"], name: "index_course_subjects_on_course_id", using: :btree
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.string   "description"
    t.integer  "status"
    t.integer  "language_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "program_id"
    t.integer  "training_standard_id"
    t.datetime "deleted_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["language_id"], name: "index_courses_on_language_id", using: :btree
    t.index ["program_id"], name: "index_courses_on_program_id", using: :btree
    t.index ["training_standard_id"], name: "index_courses_on_training_standard_id", using: :btree
  end

  create_table "evaluation_standards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "max_point",              limit: 24
    t.float    "min_point",              limit: 24
    t.float    "average_point",          limit: 24
    t.integer  "evaluation_template_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["evaluation_template_id"], name: "index_evaluation_standards_on_evaluation_template_id", using: :btree
  end

  create_table "evaluation_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "training_standard_id"
    t.datetime "deleted_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["training_standard_id"], name: "index_evaluation_templates_on_training_standard_id", using: :btree
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moving_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "sourceable_type"
    t.integer  "sourceable_id"
    t.string   "destinationable_type"
    t.integer  "destinationable_id"
    t.date     "move_date"
    t.datetime "deleted_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["destinationable_type", "destinationable_id"], name: "index_moving_histories_on_destinationable", using: :btree
    t.index ["sourceable_type", "sourceable_id"], name: "index_moving_histories_on_sourceable_type_and_sourceable_id", using: :btree
    t.index ["user_id"], name: "index_moving_histories_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.date     "start_training_date"
    t.date     "leave_date"
    t.date     "finish_training_date"
    t.boolean  "ready_for_project"
    t.date     "contract_date"
    t.string   "naitei_company"
    t.integer  "university_id"
    t.date     "graduation"
    t.integer  "language_id"
    t.integer  "trainee_type_id"
    t.integer  "user_status_id"
    t.integer  "stage_id"
    t.integer  "organization_id"
    t.float    "working_day",          limit: 24
    t.integer  "program_id"
    t.string   "staff_code"
    t.integer  "division"
    t.date     "join_div_date"
    t.datetime "deleted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["language_id"], name: "index_profiles_on_language_id", using: :btree
    t.index ["organization_id"], name: "index_profiles_on_organization_id", using: :btree
    t.index ["program_id"], name: "index_profiles_on_program_id", using: :btree
    t.index ["stage_id"], name: "index_profiles_on_stage_id", using: :btree
    t.index ["trainee_type_id"], name: "index_profiles_on_trainee_type_id", using: :btree
    t.index ["university_id"], name: "index_profiles_on_university_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
    t.index ["user_status_id"], name: "index_profiles_on_user_status_id", using: :btree
  end

  create_table "programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "program_type"
    t.integer  "parent_id"
    t.integer  "organization_id"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_programs_on_organization_id", using: :btree
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "propertiable_type"
    t.integer  "propertiable_id"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.integer  "status"
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["ownerable_type", "ownerable_id"], name: "index_properties_on_ownerable_type_and_ownerable_id", using: :btree
    t.index ["propertiable_type", "propertiable_id"], name: "index_properties_on_propertiable_type_and_propertiable_id", using: :btree
  end

  create_table "stages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.string   "description"
    t.text     "content",              limit: 65535
    t.integer  "training_standard_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["training_standard_id"], name: "index_subjects_on_training_standard_id", using: :btree
  end

  create_table "team_members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_members_on_team_id", using: :btree
    t.index ["user_id"], name: "index_team_members_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainee_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_standards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "program_id"
    t.text     "description", limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["program_id"], name: "index_training_standards_on_program_id", using: :btree
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "status"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_courses_on_course_id", using: :btree
    t.index ["user_id"], name: "index_user_courses_on_user_id", using: :btree
  end

  create_table "user_programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "program_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_user_programs_on_program_id", using: :btree
    t.index ["user_id"], name: "index_user_programs_on_user_id", using: :btree
  end

  create_table "user_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.integer  "user_course_id"
    t.integer  "course_subject_id"
    t.boolean  "current_progress"
    t.date     "user_end_date"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "subject_id"
    t.datetime "deleted_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["course_subject_id"], name: "index_user_subjects_on_course_subject_id", using: :btree
    t.index ["subject_id"], name: "index_user_subjects_on_subject_id", using: :btree
    t.index ["user_course_id"], name: "index_user_subjects_on_user_course_id", using: :btree
    t.index ["user_id"], name: "index_user_subjects_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                             default: "",        null: false
    t.string   "encrypted_password",                default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",   limit: 30
    t.string   "avatar"
    t.integer  "trainer_id"
    t.string   "type",                              default: "Trainee"
    t.datetime "deleted_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "course_subject_teams", "course_subjects"
  add_foreign_key "course_subject_teams", "teams"
  add_foreign_key "course_subjects", "courses"
  add_foreign_key "course_subjects", "subjects"
  add_foreign_key "courses", "languages"
  add_foreign_key "courses", "programs"
  add_foreign_key "courses", "training_standards"
  add_foreign_key "evaluation_standards", "evaluation_templates"
  add_foreign_key "evaluation_templates", "training_standards"
  add_foreign_key "moving_histories", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "profiles", "languages"
  add_foreign_key "profiles", "organizations"
  add_foreign_key "profiles", "programs"
  add_foreign_key "profiles", "stages"
  add_foreign_key "profiles", "trainee_types"
  add_foreign_key "profiles", "universities"
  add_foreign_key "profiles", "user_statuses"
  add_foreign_key "profiles", "users"
  add_foreign_key "programs", "organizations"
  add_foreign_key "subjects", "training_standards"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "users"
  add_foreign_key "training_standards", "programs"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_programs", "programs"
  add_foreign_key "user_programs", "users"
  add_foreign_key "user_subjects", "course_subjects"
  add_foreign_key "user_subjects", "subjects"
  add_foreign_key "user_subjects", "user_courses"
  add_foreign_key "user_subjects", "users"
end
