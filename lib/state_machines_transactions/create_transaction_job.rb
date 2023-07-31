class CreateTransactionJob < ActiveJob::Base
  queue_as :default

  def perform(attributes)
    StateMachinesTransaction.create(attributes)
  end
end
