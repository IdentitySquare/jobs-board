class AddUserIdToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :user_id, :integer
    add_index :companies, :user_id
  end
end
