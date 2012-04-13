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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120413232329) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "edition"
    t.integer  "isbn"
    t.integer  "suggested_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "department_short"
    t.string   "department_long"
    t.string   "teacher"
    t.string   "section"
    t.integer  "year"
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postings", :force => true do |t|
    t.string   "seller_email"
    t.string   "seller_name"
    t.integer  "price"
    t.integer  "location"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.boolean  "reserved",     :default => false
    t.string   "comments"
  end

  create_table "requirements", :force => true do |t|
    t.integer  "course_id"
    t.integer  "book_id"
    t.boolean  "is_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
