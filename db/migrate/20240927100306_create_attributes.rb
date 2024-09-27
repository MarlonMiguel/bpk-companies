class CreateAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :attributes do |t|
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
