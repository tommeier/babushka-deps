# My Macbook Air 13"
#TODO : Get the recipes off ben and put in this repo so I can set postgres to 9.2 in met etc
dep 'setup_mac' do
  requires 'development_dir'
  requires 'directory-current', 'directory-company', 'directory-family', 'directory-archived'

  requires 'publish-to-script'
  requires 'dotfiles', 'private-dotfiles'

  requires 'tree.managed',
           'postgres.managed',
           'redis',
           'phantomjs.managed'

  requires 'setup osx apps installed'

  # Ruby versions with rbenv
  requires 'rbenv',
           '1.9.3-p194-perf.rbenv',
           'set-global-rbenv-version',
           'bundler.gem', 'git-pulls.gem'

  requires 'elasticsearch.managed'
  requires 'libxml2.managed', 'libxslt.managed',
           'node', 'npm', 'coffeescript'
end


dep 'setup osx apps installed' do
  # Social, Web, Media etc.
  requires 'Google Chrome.app',
           'Firefox.app',
           'Skype.app',
           'NetNewsWire.app',
           'PS3 Media Server.app',
           'Transmission Remote GUI.app',
           'VLC.app'

  # Utilities
  requires 'Dropbox.app',
           '1Password.app',
           'Things.app',
           'UnRarX.app',
           'iStumbler.app',
           'iStat Menus.app',
           'Automatic.installer'

  # Development
  requires 'iTerm.app',
           'Localghost.app',
           'Sublime Text 2.configured',
           'VirtualBox.app',
           'pow'

end
