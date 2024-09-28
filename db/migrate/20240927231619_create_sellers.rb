class CreateSellers < ActiveRecord::Migration[7.1]
  def change
    create_table :sellers do |t|
      t.string :company_name
      t.string :contact_phone
      t.string :contact_email
      t.string :contact_website
      t.string :logo

      t.timestamps
    end
  end
end
