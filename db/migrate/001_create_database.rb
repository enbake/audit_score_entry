class CreateDatabase < ActiveRecord::Migration
  def self.up
    # insert schema.rb here
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

  create_table "claim_audit_note", force: true do |t|
    t.integer  "claim_audit_id",                              null: false
    t.string   "note",                limit: 256,             null: false
    t.datetime "created",                                     null: false
    t.integer  "created_employee_id",             default: 0, null: false
    t.datetime "timestamp",                                   null: false
    t.integer  "last_employee_id",                default: 0, null: false
  end

  add_index "claim_audit_note", ["claim_audit_id"], name: "FK_claim_audit_note_claim_audit", using: :btree

  create_table "claim_awaiting_audit", force: true do |t|
    t.string   "claim_number",          limit: 100,                                         null: false
    t.string   "claim_type",            limit: 5,                                           null: false
    t.integer  "carrier_branch_id",                                                         null: false
    t.decimal  "severity",                          precision: 15, scale: 5, default: 0.0,  null: false
    t.decimal  "duration_net",                      precision: 9,  scale: 1, default: 0.0,  null: false
    t.date     "loss",                                                                      null: false
    t.boolean  "active",                                                     default: true, null: false
    t.datetime "created"
    t.integer  "created_employee_id",                                        default: 0,    null: false
    t.datetime "completed"
    t.integer  "completed_employee_id",                                      default: 0,    null: false
    t.datetime "timestamp",                                                                 null: false
  end

  add_index "claim_awaiting_audit", ["carrier_branch_id"], name: "FK_claim_awaiting_audit_carrier_branch", using: :btree

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
    t.string   "first_name",           limit: 30,  default: "",    null: false
    t.string   "last_name",            limit: 50,  default: "",    null: false
    t.integer  "role_id",              limit: 2,                   null: false
    t.boolean  "is_login",                         default: false, null: false
    t.string   "mail",                 limit: 256, default: "",    null: false
    t.string   "telephone_office",     limit: 20,  default: "",    null: false
    t.string   "telephone_mobile",     limit: 20,  default: "",    null: false
    t.boolean  "is_assign_repair",                 default: false, null: false
    t.integer  "tasks_daily_max",      limit: 2,   default: 0,     null: false
    t.integer  "tasks_daily_overflow", limit: 2,   default: 0,     null: false
    t.datetime "started"
    t.integer  "credential_id",                    default: 0,     null: false
    t.boolean  "active",                           default: true,  null: false
    t.datetime "created"
    t.integer  "created_employee_id",              default: 0,     null: false
    t.datetime "timestamp",                                        null: false
    t.integer  "last_employee_id",                 default: 0,     null: false
  end

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
  end

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end
