require "test_helper"
require "state_machines_transactions/state_machines_transaction"

class StateMachinesTransactionsTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "it has a version number" do
    assert StateMachinesTransactions::VERSION
  end

  test "should create a transaction when state changes successfully" do
    vehicle = Vehicle.create
    assert_difference 'StateMachinesTransaction.count', 1 do
      vehicle.ignite!
    end
    assert_equal(StateMachinesTransaction.last.status, 'success')
  end

  test "should create a transaction when state change failed" do
    vehicle = Vehicle.create
    vehicle.ignite!
    assert_raises(StateMachines::InvalidTransition) do
       vehicle.shift_up!
    end
    perform_enqueued_jobs
    assert_equal(StateMachinesTransaction.last.status, 'failure')
  end

  test "should not create a transaction when state change failed with the same state" do
    vehicle = Vehicle.create
    assert_raises(StateMachines::InvalidTransition) do
      vehicle.park!
    end
    assert_equal(StateMachinesTransaction.count, 0)
  end
end
