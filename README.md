# StateMachinesTransactions
This gem persists the state transitions of state_machines gem. The transactions (transition data) can be used to represent the path a stateful object took to reach the current state.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "state_machines_transactions"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install state_machines_transactions
```

## Usage
Generate the database migration for state_machines_transactions table using:
```bash
$ rails generate state_machine_transactions
```

And then execute:
```bash
$ rails db:migrate
```

Add `audit_transition` inside your state machine to persist the state transitions.
```ruby
state_machine :state, initial: :parked do
    audit_transition

    state :parked
    state :idling
end
```

Use `StateMachinesTransaction` model to fetch the transactions. The schema is:
```ruby
  create_table "state_machines_transactions", force: :cascade do |t|
    t.string "object_type"
    t.integer "object_id"
    t.string "state_field"
    t.string "event"
    t.string "from_state"
    t.string "to_state"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

## Contributing
1. Fork it ( https://github.com/infraspecdev/state_machines_transactions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
