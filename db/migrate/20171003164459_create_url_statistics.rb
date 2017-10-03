class CreateUrlStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :url_statistics do |t|
      t.references :url
      t.jsonb :access_data, null: false, default: {}
    end

    add_index :url_statistics, :access_data, using: :gin
  end
end
