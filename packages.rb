dep 'postgres.managed', :version do
  version.default('9.2')
  # Assume the installed version if there is one
  version.default!(shell('psql --version').val_for('psql (PostgreSQL)')[/^\d\.\d/]) if which('psql')
  requires 'set.locale'
  installs {
    via :apt, ["postgresql-#{owner.version}", "libpq-dev"]
    via :brew, "postgresql"
  }
  provides "psql ~> #{version}.0"
end

dep 'redis', :template => 'managed' do
  provides 'redis-cli'
end

dep 'pow' do
  met? {
    "~/Library/Application Support/Pow/Current".p.exists?
  }

  meet {
    log_shell "Installing Pow", "curl get.pow.cx | sh"
  }
end

dep 'tree.managed'
dep 'elasticsearch.managed'