class Vehicle < ApplicationRecord
  state_machine :state, initial: :parked do
    audit_transition
    before_transition on: :shift_up, do: :failure_method

    event :park do
      transition [:idling, :first_gear] => :parked
    end

    event :ignite do
      transition stalled: same, parked: :idling
    end

    event :idle do
      transition first_gear: :idling
    end

    event :shift_up do
      transition idling: :first_gear, first_gear: :second_gear, second_gear: :third_gear
    end

    event :shift_down do
      transition third_gear: :second_gear, second_gear: :first_gear
    end

    event :crash do
      transition all - [:parked, :stalled] => :stalled
    end

    event :repair do
      # The first transition that matches the state and passes its conditions
      # will be used
      transition stalled: :parked
    end

    state :parked do
      def speed
        0
      end
    end

    state :idling, :first_gear do
      def speed
        10
      end
    end

    state all - [:parked, :stalled, :idling] do
      def moving?
        true
      end
    end

    state :parked, :stalled, :idling do
      def moving?
        false
      end
    end
  end

  def failure_method
    throw :halt
  end
end
