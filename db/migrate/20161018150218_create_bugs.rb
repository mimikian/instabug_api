class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string   :application_token,   null: false
      t.integer  :number,              null: false
      t.integer  :status,              null: false
      t.integer  :priority,            null: false
      t.text     :comment
      t.timestamps
    end
    add_index :bugs, [:application_token, :number], unique: true
  end
end
