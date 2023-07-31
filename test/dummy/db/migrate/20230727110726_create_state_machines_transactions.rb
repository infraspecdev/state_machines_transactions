class CreateStateMachinesTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :state_machines_transactions do |t|
      t.string :object_type
      t.integer :object_id
      t.string :state_field
      t.string :event
      t.string :from_state
      t.string :to_state
      t.string :status

      t.timestamps
    end
  end
end
