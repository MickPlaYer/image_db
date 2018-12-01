# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_28_155845) do

  create_table "images", force: :cascade do |t|
    t.string "file_name", null: false
    t.string "title"
    t.string "season"
    t.string "episode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "queried", default: false, null: false
    t.index ["file_name"], name: "index_images_on_file_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
