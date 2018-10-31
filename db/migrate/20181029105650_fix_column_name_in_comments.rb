class FixColumnNameInComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :descrition, :description
  end
end




