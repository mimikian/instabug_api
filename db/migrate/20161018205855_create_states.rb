class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string   :device              
      t.string   :os                  
      t.column  :memory, 'integer unsigned'
      t.column  :storage, 'integer unsigned'
      t.timestamps
    end
  end
end