# My Macbook Air 13"
#TODO : Get the recipes off ben and put in this repo so I can set postgres to 9.2 in met etc
dep 'setup_mac' do
  requires 'development_dir'
  requires 'current', 'company', 'family', 'archived'

  requires 'publish-to-script'
  requires 'dotfiles', 'private-dotfiles'

  requires 'benhoskings:tree.managed',
           'benhoskings:postgres.managed',
           'redis'

  requires 'setup osx apps installed'

  # Ruby versions with rbenv
  requires 'rbenv',
           '1.9.3-p194-perf.rbenv',
           'set-global-rbenv-version'

  requires 'node', 'npm'
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
           'iStat Menus.app'
           'Automatic.prefpane'

  # Development
  requires 'iTerm.app',
           'Localghost.app',
           'Sublime Text 2.configured',
           'VirtualBox.app',
           'pow'

end
