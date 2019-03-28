class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false,  default: ''
      t.string :email, null: false,  default: ''
      t.string :password_digest, null: false,  default: ''
      t.boolean :admin, default: false, null:false
      t.boolean :is_enabled, default: true, null:false

      t.timestamps
      t.index :email, unique: true
    end
  end
end
