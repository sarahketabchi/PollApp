class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
    end
  end
end
