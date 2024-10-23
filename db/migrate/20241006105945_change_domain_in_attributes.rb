class ChangeDomainInAttributes < ActiveRecord::Migration[7.1]
  def change
    remove_column :attributes, :domain, :string if column_exists?(:attributes, :domain)
    add_column :attributes, :domain, :string, limit: 1
  end
end
