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

ActiveRecord::Schema.define(version: 20131212152524) do

  create_table "carrier_branch", force: true do |t|
    t.integer  "carrier_id",                                      null: false
    t.string   "name",                limit: 100,                 null: false
    t.integer  "sequence",            limit: 2,   default: 0,     null: false
    t.boolean  "is_default",                      default: false, null: false
    t.boolean  "active",                          default: true,  null: false
    t.datetime "created"
    t.integer  "created_employee_id",             default: 0,     null: false
    t.datetime "timestamp",                                       null: false
    t.integer  "last_employee_id",                default: 0,     null: false
  end

  create_table "claim_audit", force: true do |t|
    t.integer  "audit_type_id",           limit: 2,                                         null: false
    t.integer  "claim_awaiting_audit_id",                                                   null: false
    t.datetime "reviewed",                                                                  null: false
    t.integer  "reviewer_employee_id",                                                      null: false
    t.integer  "estimator_employee_id",                                                     null: false
    t.decimal  "score",                             precision: 15, scale: 5, default: 0.0,  null: false
    t.decimal  "estimate_leakage_over",             precision: 15, scale: 5, default: 0.0,  null: false
    t.decimal  "estimate_leakage_under",            precision: 15, scale: 5, default: 0.0,  null: false
    t.boolean  "active",                                                     default: true, null: false
    t.datetime "timestamp",                                                                 null: false
    t.integer  "last_employee_id",                                           default: 0,    null: false
  end

  add_index "claim_audit", ["audit_type_id"], name: "FK_claim_audit_audit_type", using: :btree
  add_index "claim_audit", ["claim_awaiting_audit_id"], name: "FK_claim_audit_claim_awaiting_audit", using: :btree
  add_index "claim_audit", ["estimator_employee_id"], name: "FK_claim_audit_estimator_employee", using: :btree
  add_index "claim_audit", ["reviewer_employee_id"], name: "FK_claim_audit_reviewer_employee", using: :btree

  create_table "claim_audit_category", force: true do |t|
    t.integer  "claim_audit_id",                                                            null: false
    t.integer  "audit_subcategory_id", limit: 2,                                            null: false
    t.integer  "response_id",          limit: 2,                                            null: false
    t.decimal  "exception",                        precision: 7,  scale: 5, default: 0.0,   null: false
    t.decimal  "amount",                           precision: 15, scale: 5, default: 0.0,   null: false
    t.boolean  "is_under",                                                  default: false, null: false
    t.string   "note",                 limit: 100
    t.boolean  "active",                                                    default: true,  null: false
    t.datetime "created",                                                                   null: false
    t.integer  "created_employee_id",                                       default: 0,     null: false
    t.datetime "timestamp",                                                                 null: false
    t.integer  "last_employee_id",                                          default: 0,     null: false
  end

  add_index "claim_audit_category", ["audit_subcategory_id"], name: "FK_claim_audit_category_audit_subcategory", using: :btree

  create_table "claim_audit_comments", force: true do |t|
    t.text     "comment"
    t.string   "written_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reference_id"
    t.string   "reference_type"
    t.text     "auxiliary1"
    t.text     "auxiliary2"
  end

  add_index "claim_audit_comments", ["reference_id", "reference_type"], name: "index_claim_audit_comments_on_reference_id_and_reference_type", using: :btree

  create_table "claim_audit_detail_files", force: true do |t|
    t.string   "category"
    t.text     "area"
    t.string   "answer"
    t.decimal  "exception"
    t.text     "note"
    t.string   "indicator"
    t.integer  "amount"
    t.string   "pct_exception"
    t.integer  "claim_audit_question_id"
    t.integer  "claim_audit_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claim_audit_detail_files", ["claim_audit_entry_id"], name: "index_claim_audit_detail_files_on_claim_audit_entry_id", using: :btree
  add_index "claim_audit_detail_files", ["claim_audit_question_id"], name: "index_claim_audit_detail_files_on_claim_audit_question_id", using: :btree

  create_table "claim_audit_entries", force: true do |t|
    t.integer  "reviewer_id"
    t.datetime "review"
    t.string   "claim"
    t.string   "estimator"
    t.float    "overall_score"
    t.float    "admin_score"
    t.string   "compliance_score"
    t.string   "estimating_score"
    t.float    "leakage_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "carrier_branch_id"
    t.integer  "claim_awaiting_audit_id"
    t.string   "claim_type"
  end

  add_index "claim_audit_entries", ["carrier_branch_id"], name: "index_claim_audit_entries_on_carrier_branch_id", using: :btree
  add_index "claim_audit_entries", ["claim_awaiting_audit_id"], name: "index_claim_audit_entries_on_claim_awaiting_audit_id", using: :btree

  create_table "claim_audit_note", force: true do |t|
    t.integer  "claim_audit_id",                              null: false
    t.string   "note",                limit: 256,             null: false
    t.datetime "created",                                     null: false
    t.integer  "created_employee_id",             default: 0, null: false
    t.datetime "timestamp",                                   null: false
    t.integer  "last_employee_id",                default: 0, null: false
  end

  add_index "claim_audit_note", ["claim_audit_id"], name: "FK_claim_audit_note_claim_audit", using: :btree

  create_table "claim_audit_questions", force: true do |t|
    t.string   "category"
    t.text     "question"
    t.string   "response"
    t.decimal  "min_exception"
    t.decimal  "max_exception"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_amount",    default: 0
  end

  create_table "claim_awaiting_audit", force: true do |t|
    t.string   "claim_number",          limit: 100,                                         null: false
    t.string   "claim_type",            limit: 5,                                           null: false
    t.integer  "carrier_branch_id",                                                         null: false
    t.decimal  "severity",                          precision: 15, scale: 5, default: 0.0,  null: false
    t.decimal  "duration_net",                      precision: 9,  scale: 1, default: 0.0,  null: false
    t.date     "estimate_date",                                                             null: false
    t.boolean  "active",                                                     default: true, null: false
    t.datetime "created"
    t.integer  "created_employee_id",                                        default: 0,    null: false
    t.datetime "completed"
    t.integer  "completed_employee_id",                                      default: 0,    null: false
    t.datetime "timestamp",                                                                 null: false
    t.integer  "employee_id"
    t.integer  "uploader_employee_id"
    t.date     "last_reviewed_date"
    t.boolean  "new_upload",                                                 default: true
  end

  add_index "claim_awaiting_audit", ["carrier_branch_id"], name: "FK_claim_awaiting_audit_carrier_branch", using: :btree
  add_index "claim_awaiting_audit", ["employee_id"], name: "index_claim_awaiting_audit_on_employee_id", using: :btree
  add_index "claim_awaiting_audit", ["uploader_employee_id"], name: "index_claim_awaiting_audit_on_uploader_employee_id", using: :btree

  create_table "claim_awaiting_audits_employees", id: false, force: true do |t|
    t.integer "claim_awaiting_audit_id"
    t.integer "employee_id"
  end

  create_table "constant_estimating_system", force: true do |t|
    t.string  "name",   limit: 50,                null: false
    t.boolean "active",            default: true, null: false
  end

  create_table "constant_response", force: true do |t|
    t.integer "response_type_id", limit: 2,                 null: false
    t.string  "name",             limit: 30,                null: false
    t.integer "sequence",         limit: 2,                 null: false
    t.boolean "active",                      default: true, null: false
  end

  add_index "constant_response", ["response_type_id"], name: "FK_constant_response_response_type", using: :btree

  create_table "constant_type", force: true do |t|
    t.string  "type",   limit: 30,                null: false
    t.string  "name",   limit: 30,                null: false
    t.boolean "active",            default: true, null: false
  end

  create_table "employee", force: true do |t|
    t.string   "first_name",             limit: 30, default: "",    null: false
    t.string   "last_name",              limit: 50, default: "",    null: false
    t.integer  "role_id",                limit: 2,                  null: false
    t.boolean  "is_login",                          default: false, null: false
    t.string   "telephone_office",       limit: 20, default: "",    null: false
    t.string   "telephone_mobile",       limit: 20, default: "",    null: false
    t.boolean  "is_assign_repair",                  default: false, null: false
    t.integer  "tasks_daily_max",        limit: 2,  default: 0,     null: false
    t.integer  "tasks_daily_overflow",   limit: 2,  default: 0,     null: false
    t.datetime "started"
    t.integer  "credential_id",                     default: 0,     null: false
    t.boolean  "active",                            default: true,  null: false
    t.datetime "created"
    t.integer  "created_employee_id",               default: 0,     null: false
    t.datetime "timestamp",                                         null: false
    t.integer  "last_employee_id",                  default: 0,     null: false
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_admin?",                         default: false
  end

  add_index "employee", ["email"], name: "index_employee_on_email", using: :btree
  add_index "employee", ["reset_password_token"], name: "index_employee_on_reset_password_token", unique: true, using: :btree

  create_table "estimating_audit", force: true do |t|
    t.integer  "audit_type_id",         limit: 2,                                         null: false
    t.integer  "carrier_branch_id",                                                       null: false
    t.integer  "estimating_system_id",  limit: 2,                                         null: false
    t.datetime "start",                                                                   null: false
    t.datetime "end",                                                                     null: false
    t.integer  "estimator_employee_id",                                                   null: false
    t.integer  "estimate_count",                                           default: 0,    null: false
    t.decimal  "score",                           precision: 15, scale: 5, default: 0.0,  null: false
    t.integer  "score_employee_id",                                        default: 0,    null: false
    t.boolean  "active",                                                   default: true, null: false
    t.datetime "created",                                                                 null: false
    t.integer  "created_employee_id",                                      default: 0,    null: false
    t.datetime "timestamp",                                                               null: false
    t.integer  "last_employee_id",                                         default: 0,    null: false
  end

  add_index "estimating_audit", ["audit_type_id"], name: "FK_estimating_audit_audit_type", using: :btree
  add_index "estimating_audit", ["carrier_branch_id"], name: "FK_estimating_audit_carrier_branch", using: :btree
  add_index "estimating_audit", ["estimating_system_id"], name: "FK_estimating_audit_estimating_system", using: :btree
  add_index "estimating_audit", ["estimator_employee_id"], name: "FK_estimating_audit_estimator_employee", using: :btree
  add_index "estimating_audit", ["score_employee_id"], name: "FK_estimating_audit_score_employee", using: :btree

  create_table "estimating_audit_category", force: true do |t|
    t.integer  "estimating_audit_id",                                                       null: false
    t.integer  "estimating_category_id", limit: 2,                                          null: false
    t.decimal  "metric",                           precision: 15, scale: 5,                 null: false
    t.boolean  "is_negative",                                               default: false, null: false
    t.boolean  "active",                                                    default: true,  null: false
    t.datetime "created",                                                                   null: false
    t.integer  "created_employee_id",                                       default: 0,     null: false
    t.datetime "timestamp",                                                                 null: false
    t.integer  "last_employee_id",                                          default: 0,     null: false
  end

  add_index "estimating_audit_category", ["estimating_audit_id"], name: "FK_estimating_audit_category_estimating_audit", using: :btree
  add_index "estimating_audit_category", ["estimating_category_id"], name: "FK_estimating_audit_category_estimating_category", using: :btree

  create_table "estimating_audit_note", force: true do |t|
    t.integer  "estimating_audit_id",                         null: false
    t.string   "note",                limit: 256,             null: false
    t.datetime "created",                                     null: false
    t.integer  "created_employee_id",             default: 0, null: false
    t.datetime "timestamp",                                   null: false
    t.integer  "last_employee_id",                default: 0, null: false
  end

  add_index "estimating_audit_note", ["estimating_audit_id"], name: "FK_estimating_audit_note_estimating_audit", using: :btree

  create_table "system_audit_category", force: true do |t|
    t.integer  "audit_type_id",    limit: 2,                  null: false
    t.string   "name",             limit: 50,                 null: false
    t.string   "exception_name",   limit: 50, default: "",    null: false
    t.integer  "sequence",         limit: 2,                  null: false
    t.boolean  "is_exception",                default: false, null: false
    t.boolean  "is_impact",                   default: false, null: false
    t.boolean  "is_estimating",               default: false, null: false
    t.boolean  "active",                      default: true,  null: false
    t.datetime "timestamp",                                   null: false
    t.integer  "last_employee_id",            default: 0,     null: false
  end

  add_index "system_audit_category", ["audit_type_id"], name: "FK_system_audit_category_audit_type", using: :btree

  create_table "system_audit_subcategory", force: true do |t|
    t.integer  "audit_category_id", limit: 2,                                          null: false
    t.string   "name",              limit: 50,                                         null: false
    t.integer  "sequence",          limit: 2,                                          null: false
    t.decimal  "minimum",                      precision: 15, scale: 5, default: 0.0,  null: false
    t.decimal  "maximum",                      precision: 15, scale: 5, default: 0.0,  null: false
    t.boolean  "active",                                                default: true, null: false
    t.datetime "timestamp"
    t.integer  "last_employee_id",                                      default: 0,    null: false
  end

  add_index "system_audit_subcategory", ["audit_category_id"], name: "FK_system_audit_subcategory_audit_category", using: :btree

  create_table "system_estimating_category", force: true do |t|
    t.integer  "audit_type_id",    limit: 2,                 null: false
    t.string   "name",             limit: 30,                null: false
    t.string   "abbreviation",     limit: 10,                null: false
    t.integer  "metric_type_id",   limit: 2,                 null: false
    t.integer  "sequence",         limit: 2,                 null: false
    t.boolean  "active",                      default: true, null: false
    t.datetime "timestamp",                                  null: false
    t.integer  "last_employee_id",            default: 0,    null: false
  end

  add_index "system_estimating_category", ["audit_type_id"], name: "FK_system_estimating_category_audit_type", using: :btree
  add_index "system_estimating_category", ["metric_type_id"], name: "FK_system_estimating_category_metric_type", using: :btree

  create_table "unsaved_awaiting_audits", force: true do |t|
    t.string   "claim_number"
    t.string   "claim_type"
    t.integer  "carrier_branch_id"
    t.decimal  "severity"
    t.decimal  "duration_net"
    t.date     "estimate_date"
    t.boolean  "active"
    t.integer  "created_employee_id"
    t.datetime "completed"
    t.integer  "completed_employee_id"
    t.integer  "employee_id"
    t.datetime "created"
    t.datetime "timestamp"
    t.string   "batch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_employee_id"
  end

  add_index "unsaved_awaiting_audits", ["creator_employee_id"], name: "index_unsaved_awaiting_audits_on_creator_employee_id", using: :btree

end
