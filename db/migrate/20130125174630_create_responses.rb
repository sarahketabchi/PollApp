class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :poll_id
      t.string :option
    end
  end
end
