class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :full_url
      t.string :short_code

      t.timestamps
    end
    add_index :urls, :short_code, unique: true
  end
end
