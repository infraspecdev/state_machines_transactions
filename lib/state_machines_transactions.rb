require "state_machines"
require "state_machines-activerecord"
require "state_machines_transactions/state_machines_transaction"
require "state_machines_transactions/create_transaction_job"

module StateMachinesTransactions
  def audit_transition
    state_machine = self
    state_machine.after_transition(any => any) do |object, _transition|
      state_transaction = StateMachinesTransaction.create(
        object_type: object.class.name,
        object_id: object.id,
        state_field: state_machine.attribute,
        event: _transition.event,
        from_state: _transition.from,
        to_state: _transition.to,
        status: 'success'
      )
    end

    state_machine.after_failure do |object, _transition|
      state_transaction = StateMachinesTransaction.new(
        object_type: object.class.name,
        object_id: object.id,
        state_field: state_machine.attribute,
        event: _transition.event,
        from_state: _transition.from,
        to_state: _transition.to,
        status: 'failure'
      )
      CreateTransactionJob.perform_later(state_transaction.attributes)
    end
  end
end

StateMachines::Machine.include StateMachinesTransactions
