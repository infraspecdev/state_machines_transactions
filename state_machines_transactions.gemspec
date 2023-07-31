require_relative "lib/state_machines_transactions/version"

Gem::Specification.new do |spec|
  spec.name        = "state_machines_transactions"
  spec.version     = StateMachinesTransactions::VERSION
  spec.authors     = ["Abhilash Achuthan"]
  spec.email       = ["abhilash@infraspec.dev"]
  spec.homepage    = "https://github.com/infraspecdev/state_machines_transactions"
  spec.summary     = "Summary of StateMachinesTransactions."
  spec.description = "Description of StateMachinesTransactions."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/infraspecdev/state_machines_transactions"
  spec.metadata["changelog_uri"] = "https://github.com/infraspecdev/state_machines_transactions"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.6"
  spec.add_dependency "state_machines", "~> 0.6.0"
  spec.add_dependency 'state_machines-activerecord', '~> 0.9.0'
end
