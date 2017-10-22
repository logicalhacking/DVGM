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

ActiveRecord::Schema.define(version: 20170401153520) do

  create_table "grades", force: :cascade do |t|
    t.integer  "lecture_id"
    t.integer  "student_id"
    t.decimal  "grade"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_grades_on_lecture_id"
    t.index ["student_id"], name: "index_grades_on_student_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name"
    t.integer  "lecturer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["lecturer_id"], name: "index_lectures_on_lecturer_id"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "role"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
