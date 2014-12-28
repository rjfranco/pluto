class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.belongs_to :user, index: true
      t.integer :time
      t.date :date
      t.boolean :remote, default: false

      t.timestamps
    end
  end
end
