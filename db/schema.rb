# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_04_08_100000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "title"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "exam_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "exam_id", null: false
    t.integer "status", default: 0
    t.integer "score"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "result_status", default: 0
    t.jsonb "detailed_results"
    t.bigint "selected_topic_id"
    t.index ["exam_id"], name: "index_exam_sessions_on_exam_id"
    t.index ["selected_topic_id"], name: "index_exam_sessions_on_selected_topic_id"
    t.index ["user_id"], name: "index_exam_sessions_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exam_type", default: 0
    t.integer "time_duration"
    t.string "difficulty"
    t.index ["topic_id"], name: "index_exams_on_topic_id"
  end

  create_table "exercise_authorizations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "topic_id", null: false
    t.boolean "authorized"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_exercise_authorizations_on_topic_id"
    t.index ["user_id"], name: "index_exercise_authorizations_on_user_id"
  end

  create_table "external_activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "score"
    t.bigint "user_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_external_activities_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "topic_id"
    t.text "explanation"
    t.index ["exam_id"], name: "index_questions_on_exam_id"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
  end

  create_table "session_answers", force: :cascade do |t|
    t.bigint "exam_session_id", null: false
    t.bigint "question_id", null: false
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_session_answers_on_answer_id"
    t.index ["exam_session_id"], name: "index_session_answers_on_exam_session_id"
    t.index ["question_id"], name: "index_session_answers_on_question_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.string "full_name"
    t.string "canac"
    t.string "cpf"
    t.string "phone"
    t.integer "student_type", default: 0
    t.integer "credits", default: 0
    t.boolean "must_change_password", default: true
    t.index ["canac"], name: "index_users_on_canac", unique: true
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["credits"], name: "index_users_on_credits"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["must_change_password"], name: "index_users_on_must_change_password"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["student_type"], name: "index_users_on_student_type"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "exam_sessions", "exams"
  add_foreign_key "exam_sessions", "topics", column: "selected_topic_id"
  add_foreign_key "exam_sessions", "users"
  add_foreign_key "exams", "topics"
  add_foreign_key "exercise_authorizations", "topics"
  add_foreign_key "exercise_authorizations", "users"
  add_foreign_key "external_activities", "users"
  add_foreign_key "questions", "exams"
  add_foreign_key "questions", "topics"
  add_foreign_key "session_answers", "answers"
  add_foreign_key "session_answers", "exam_sessions"
  add_foreign_key "session_answers", "questions"
end
