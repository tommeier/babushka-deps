dep 'libxml2.managed' do
  installs {
    via :brew, 'libxml2'
  }
  provides []
end

dep 'libxslt.managed' do
  installs {
    via :brew, 'libxslt'
  }
  provides []
end

dep 'node', :template => 'managed'

dep 'npm' do
  requires 'node'

  met? { in_path? 'npm' }
  meet {
    log_shell 'Run npm install.sh', 'curl http://npmjs.org/install.sh | clean=no sh'
  }
end

