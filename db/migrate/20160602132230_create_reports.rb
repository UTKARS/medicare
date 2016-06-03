class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :bgl
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
