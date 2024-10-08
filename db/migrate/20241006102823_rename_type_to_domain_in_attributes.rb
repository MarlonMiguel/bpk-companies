class RenameTypeToDomainInAttributes < ActiveRecord::Migration[7.1]
  def change
    rename_column :attributes, :type, :domain
  end
end
