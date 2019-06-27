class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.boolean :done
      t.datetime :associated_date
      t.string :summary
      t.text :description

      t.timestamps
    end
  end
end
