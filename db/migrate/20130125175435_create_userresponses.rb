class CreateUserresponses < ActiveRecord::Migration
  def change
    create_table :userresponses do |t|
      t.integer :user_id
      t.integer :response_id
    end
  end
end
