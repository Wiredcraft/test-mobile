class CreateSeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :seeds do |t|
      t.string :seed
      t.timestamps :expires_at
    end
  end
end
