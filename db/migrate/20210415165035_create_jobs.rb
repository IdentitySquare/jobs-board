class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.references :company, null: false, foreign_key: true
      t.integer :job_type, default: 0

      t.timestamps
    end
  end
end
