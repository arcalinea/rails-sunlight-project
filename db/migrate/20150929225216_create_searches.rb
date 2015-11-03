class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
    	t.string :politician
    	t.string :organization
      t.integer :year
      t.string :total

      t.references :user
      t.timestamps null: false
    end
  end
end
