class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star
      t.references :reservation, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :guest_id
      t.integer :host_id
      t.string :type

      t.timestamps
    end
  end
end
