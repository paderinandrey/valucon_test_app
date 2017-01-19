class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :email,  null: false, default: ""
      t.text :text,     null: false, default: ""

      t.timestamps
    end
  end
end
