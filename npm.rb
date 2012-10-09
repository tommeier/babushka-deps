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
  requires 'node', 'npm-bin.path'

  met? { in_path? 'npm' }
  meet {
    log_shell 'Run npm install.sh', 'curl http://npmjs.org/install.sh | clean=no sh'
  }
end

dep 'npm-bin.path' do
  met? {
    `echo $PATH` =~ /#{Regexp.escape('/usr/local/share/npm/bin')}/
  }
  meet {
    log_shell 'Update .dotfiles - Ensure that "/usr/local/share/npm/bin" is applied to $PATH', "echo 'manual update required'"
  }
end

dep 'coffeescript' do
  requires 'npm'

  met? { in_path?('cake') }
  meet {
    log_shell 'Run npm install - coffeescript', 'npm install -g coffee-script'
  }
end


