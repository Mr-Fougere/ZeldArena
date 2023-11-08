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

ActiveRecord::Schema[7.0].define(version: 2023_11_08_090048) do
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

  create_table "battle_actions", force: :cascade do |t|
    t.float "damage", default: 0.0, null: false
    t.integer "result", default: 0, null: false
    t.integer "battle_id", null: false
    t.integer "attacker_id", null: false
    t.integer "defender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attacker_id"], name: "index_battle_actions_on_attacker_id"
    t.index ["battle_id"], name: "index_battle_actions_on_battle_id"
    t.index ["defender_id"], name: "index_battle_actions_on_defender_id"
  end

  create_table "battle_character_equipments", force: :cascade do |t|
    t.integer "battle_character_id", null: false
    t.integer "equipment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_character_id"], name: "index_battle_character_equipments_on_battle_character_id"
    t.index ["equipment_id"], name: "index_battle_character_equipments_on_equipment_id"
  end

  create_table "battle_characters", force: :cascade do |t|
    t.float "current_health_points", null: false
    t.float "current_attack_power", null: false
    t.float "current_armor_points", null: false
    t.float "current_speed", null: false
    t.float "critical_hit_rate", null: false
    t.float "dodge_rate", null: false
    t.float "miss_rate", null: false
    t.float "critical_multiplier", null: false
    t.integer "character_id", null: false
    t.integer "battle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_battle_characters_on_battle_id"
    t.index ["character_id"], name: "index_battle_characters_on_character_id"
  end

  create_table "battles", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "winner_character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["winner_character_id"], name: "index_battles_on_winner_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.float "health_points", default: 30.0
    t.float "attack_power", default: 2.5
    t.float "armor_points", default: 0.0
    t.float "speed", default: 2.5
    t.float "critical_rate", default: 5.0
    t.float "critical_multiplier", default: 1.5
    t.float "dodge_rate", default: 5.0
    t.float "miss_rate", default: 5.0
    t.integer "experience_points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "effects", force: :cascade do |t|
    t.string "name", null: false
    t.integer "affected_stat", default: 0, null: false
    t.integer "affected_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.boolean "unlocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment_effects", force: :cascade do |t|
    t.integer "equipment_id", null: false
    t.integer "effect_id", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effect_id"], name: "index_equipment_effects_on_effect_id"
    t.index ["equipment_id"], name: "index_equipment_effects_on_equipment_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "battle_actions", "battle_characters", column: "attacker_id"
  add_foreign_key "battle_actions", "battle_characters", column: "defender_id"
  add_foreign_key "battle_actions", "battles"
  add_foreign_key "battle_character_equipments", "battle_characters"
  add_foreign_key "battle_character_equipments", "equipment"
  add_foreign_key "battle_characters", "battles"
  add_foreign_key "battle_characters", "characters"
  add_foreign_key "battles", "characters", column: "winner_character_id"
  add_foreign_key "equipment_effects", "effects"
  add_foreign_key "equipment_effects", "equipment"
end
