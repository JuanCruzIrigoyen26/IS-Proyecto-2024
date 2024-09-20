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

ActiveRecord::Schema[7.0].define(version: 2024_05_14_212120) do
  create_table "account_answers", force: :cascade do |t|
    t.boolean "correct", default: false
    t.integer "account_id"
    t.integer "answer_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_answers_on_account_id"
    t.index ["answer_id"], name: "index_account_answers_on_answer_id"
    t.index ["question_id"], name: "index_account_answers_on_question_id"
  end

  create_table "account_games", force: :cascade do |t|
    t.integer "account_id"
    t.integer "game_id"
    t.integer "account_knowledge", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_games_on_account_id"
    t.index ["game_id"], name: "index_account_games_on_game_id"
  end

  create_table "account_tests", force: :cascade do |t|
    t.boolean "test_completed", default: false
    t.integer "correct_answers", default: 0
    t.integer "account_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_tests_on_account_id"
    t.index ["test_id"], name: "index_account_tests_on_test_id"
  end

  create_table "account_trivias", force: :cascade do |t|
    t.boolean "trivias_completed", default: false
    t.integer "account_id"
    t.integer "trivias_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_trivias_on_account_id"
    t.index ["trivias_id"], name: "index_account_trivias_on_trivias_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "nickname"
    t.string "password"
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer "number"
    t.boolean "correct", default: false
    t.text "description"
    t.integer "question_number"
    t.string "test_letter"
    t.integer "game_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.string "genre"
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_games_on_number", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.integer "number"
    t.text "description"
    t.string "test_letter"
    t.integer "game_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "letter", limit: 1
    t.string "description"
    t.integer "cant_questions", default: 0
    t.integer "game_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["letter"], name: "index_tests_on_letter", unique: true
  end

  create_table "trivias", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.text "description"
    t.string "test_letter"
    t.integer "game_number"
    t.string "mode", default: "beginner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_answers", "accounts"
  add_foreign_key "account_answers", "answers"
  add_foreign_key "account_answers", "questions"
  add_foreign_key "account_games", "accounts"
  add_foreign_key "account_games", "games"
  add_foreign_key "account_tests", "accounts"
  add_foreign_key "account_tests", "tests"
  add_foreign_key "account_trivias", "accounts"
  add_foreign_key "account_trivias", "trivias", column: "trivias_id"
end
