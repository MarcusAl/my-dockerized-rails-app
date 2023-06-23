class AddCounterTable < ActiveRecord::Migration[7.0]
  def change
    create_table :counters, id: :uuid, force: :cascade do |t|
      t.column :hit_count, :integer
    
      t.timestamps
    end
  end
end
