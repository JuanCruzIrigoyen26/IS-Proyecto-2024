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
  create_table "account_answer", force: :cascade do |t|
    t.integer "account_id"
    t.integer "answer_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_answers_on_account_id"
    t.index ["answer_id"], name: "index_account_answers_on_answer_id"
    t.index ["question_id"], name: "index_account_answers_on_question_id"
  end

  create_table "account_game", force: :cascade do |t|
    t.string "account_knowledge", default: "basic"
    t.integer "account_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_games_on_account_id"
    t.index ["game_id"], name: "index_account_games_on_game_id"
  end

  create_table "account_test", force: :cascade do |t|
    t.boolean "test_completed", default: false
    t.integer "account_id"
    t.integer "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_tests_on_account_id"
    t.index ["test_id"], name: "index_account_tests_on_test_id"
  end

  create_table "account_trivia", force: :cascade do |t|
    t.boolean "trivia_completed", default: false
    t.integer "correct_questions", default: 0
    t.integer "account_id"
    t.integer "trivia_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_trivias_on_account_id"
    t.index ["trivia_id"], name: "index_account_trivias_on_trivia_id"
  end

  create_table "account", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "nickname"
    t.string "password"
    t.integer "progress", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answer", force: :cascade do |t|
    t.integer "number"
    t.boolean "correct", default: false
    t.text "description"
    t.integer "question_number"
    t.string "test_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game", force: :cascade do |t|
    t.integer "number", limit: 1
    t.string "name"
    t.string "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_games_on_number", unique: true
  end

  create_table "question", force: :cascade do |t|
    t.integer "number"
    t.text "description"
    t.string "test_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test", force: :cascade do |t|
    t.string "letter", limit: 1
    t.string "description"
    t.integer "cant_questions", default: 0
    t.integer "game_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["letter"], name: "index_tests_on_letter", unique: true
  end

  create_table "trivia", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.text "description"
    t.string "test_letter"
    t.string "mode", default: "beginner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_answer", "account"
  add_foreign_key "account_answer", "answer"
  add_foreign_key "account_answer", "question"
  add_foreign_key "account_game", "account"
  add_foreign_key "account_game", "game"
  add_foreign_key "account_test", "account"
  add_foreign_key "account_test", "test"
  add_foreign_key "account_trivia", "account"
  add_foreign_key "account_trivia", "trivia", column: "trivia_id"
end
