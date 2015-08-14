# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150422085827) do

  create_table "dict_work_natures", force: true do |t|
    t.string   "nature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "initial_passwords", force: true do |t|
    t.string   "phone"
    t.string   "password"
    t.string   "effective_time"
    t.string   "effective_create_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "position_apply", primary_key: "position_apply_id", force: true do |t|
    t.integer "position_id"
    t.integer "user_id"
    t.integer "current_times"
    t.integer "status",        default: 0, null: false
  end

  add_index "position_apply", ["position_id"], name: "position_id", using: :btree
  add_index "position_apply", ["user_id"], name: "user_id", using: :btree

  create_table "resume_educations", force: true do |t|
    t.integer  "resume_id"
    t.string   "begin_time"
    t.string   "end_time"
    t.string   "school"
    t.integer  "dict_major_id"
    t.string   "major"
    t.text     "describe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_languages", force: true do |t|
    t.string   "language"
    t.string   "language_level"
    t.string   "listen"
    t.string   "listen_level"
    t.string   "writes"
    t.string   "write_level"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_projects", force: true do |t|
    t.integer  "resume_id"
    t.string   "begin_time"
    t.string   "end_time"
    t.string   "project"
    t.text     "project_introduce"
    t.text     "responsible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_skills", force: true do |t|
    t.string   "skill_name"
    t.string   "skill_level"
    t.string   "skill_time"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_trains", force: true do |t|
    t.string   "begin_work"
    t.string   "end_work"
    t.string   "train_school"
    t.string   "train_course"
    t.string   "train_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_workexperiences", force: true do |t|
    t.integer  "resume_id"
    t.string   "company"
    t.string   "begin_time"
    t.string   "end_time"
    t.string   "department"
    t.string   "position"
    t.text     "responsible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "dict_sex_id"
    t.integer  "dict_industry_function"
    t.integer  "dct_workexperice_id"
    t.integer  "dict_education_id"
    t.integer  "dict_salary_id"
    t.integer  "dict_labor_relations_id"
    t.integer  "dict_marries_id"
    t.integer  "dict_households_id"
    t.integer  "dict_months_basic_salaries_id"
    t.integer  "dict_work_places_id"
    t.integer  "dict_work_times_id"
    t.integer  "dict_vacation_benefits_id"
    t.integer  "dict_social_security_payment_id"
    t.integer  "dict_business_trips_id"
    t.string   "source"
    t.integer  "dict_age_id"
    t.string   "live"
    t.string   "address"
    t.string   "permanent"
    t.string   "phone"
    t.string   "email"
    t.string   "position_status"
    t.string   "year_money"
    t.string   "keyword"
    t.text     "self_evaluation"
    t.string   "work_time"
    t.string   "hope_industry"
    t.string   "hope_pay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "token", primary_key: "token_id", force: true do |t|
    t.string  "token_name",    limit: 11
    t.integer "token_expires"
    t.integer "token_status",             default: 0, null: false
  end

  create_table "tokens", force: true do |t|
    t.string   "token"
    t.string   "overdue_time"
    t.string   "token_create_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user", primary_key: "user_id", force: true do |t|
    t.string  "user_nickname",        limit: 11
    t.string  "user_phone",           limit: 11
    t.string  "user_password",        limit: 20
    t.integer "user_register_time"
    t.integer "hr_privilege",                    default: 0, null: false
    t.integer "user_status",                     default: 0
    t.integer "dict_sex_id",                     default: 0, null: false
    t.string  "weixin_union_id",      limit: 20
    t.integer "weixin_authorization",            default: 0, null: false
    t.string  "weibo_id",             limit: 11
    t.string  "user_equipment",       limit: 11
    t.string  "source",               limit: 11
  end

  add_index "user", ["user_id"], name: "user_id", using: :btree
  add_index "user", ["user_phone"], name: "user_phone", using: :btree

  create_table "user_bank_accouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "dict_bank_id"
    t.string   "card"
    t.string   "pay_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_collect", primary_key: "user_collect_id", force: true do |t|
    t.integer "user_id",               default: 0, null: false
    t.integer "position_id",           default: 0, null: false
    t.integer "position_collect_time", default: 0, null: false
    t.integer "resume_id",             default: 0, null: false
    t.integer "resume_collect_time",   default: 0, null: false
    t.integer "company_id",            default: 0, null: false
    t.integer "company_collect_time",  default: 0, null: false
    t.integer "collect_type",          default: 0, null: false
  end

  create_table "user_commonly_accountings", force: true do |t|
    t.integer  "user_id"
    t.string   "card"
    t.string   "name"
    t.integer  "status"
    t.integer  "commonly_type"
    t.integer  "commonly_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_dynamics", force: true do |t|
    t.integer  "user_id"
    t.string   "dynamic"
    t.string   "dynamic_time"
    t.integer  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_evaluation_details", force: true do |t|
    t.integer  "evaluation_user_id"
    t.integer  "by_evaluation_user_id"
    t.integer  "evaluation_score"
    t.string   "evaluation_time"
    t.integer  "dict_evaluation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_evaluation_summaries", force: true do |t|
    t.integer  "evaluation_user_id"
    t.integer  "by_evaluation_user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_evaluation_trends", force: true do |t|
    t.integer  "evaluation_user_id"
    t.integer  "by_evaluation_user_id"
    t.integer  "score"
    t.string   "evaluation_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_evaluations", force: true do |t|
    t.integer  "user_id"
    t.string   "evaluation_friend_string"
    t.string   "last_evaluation_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_integral_changes", force: true do |t|
    t.integer  "user_id"
    t.string   "integral"
    t.string   "change_time"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_invitations", force: true do |t|
    t.integer  "user_id"
    t.string   "invitation_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_logins", force: true do |t|
    t.integer  "user_id"
    t.string   "login_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_other_welfares", force: true do |t|
    t.integer  "user_id"
    t.string   "other_welfare_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pays", force: true do |t|
    t.integer  "user_id"
    t.string   "pay_account"
    t.string   "pay_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_relation_answer", force: true do |t|
    t.integer "answer_id"
    t.text    "answer_library"
    t.integer "answer_key"
    t.string  "answer_string",  limit: 111
  end

  create_table "user_resume_competitions", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_resume_id"
    t.string   "competition_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_resume_comprehensives", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_resume_id"
    t.string   "comprehensive_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_resume_languages", force: true do |t|
    t.integer  "resume_id"
    t.string   "language_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_resume_other_monetary_benefits", id: false, force: true do |t|
    t.integer "id",                         null: false
    t.integer "hirelib_resume_id"
    t.integer "other_monetary_benefits_id"
    t.integer "number"
  end

  create_table "user_resume_qualities", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_resume_id"
    t.string   "quality_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_weixin_relation", force: true do |t|
    t.integer "user_id"
    t.string  "weixin_union_id", limit: 111
    t.string  "rand_string",     limit: 111
    t.integer "status",                      default: 0, null: false
  end

end
