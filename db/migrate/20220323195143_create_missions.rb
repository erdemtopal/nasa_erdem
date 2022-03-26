class CreateMissions < ActiveRecord::Migration[7.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.integer :weight
      t.string :firstlocation
      t.string :secondlocation
      t.integer :fuel
      t.string :error

      t.timestamps
    end
  end
end
