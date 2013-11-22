class CreateCallTypes < ActiveRecord::Migration
  def change
    create_table :call_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
