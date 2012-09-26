# My Macbook Air 13"

dep 'setup_mac' do
  requires 'development_dir'
  requires 'current', 'company', 'family', 'archived'

  requires 'dotfiles', 'private-dotfiles'

  requires 'ack.managed',
           'tree.managed',
           'postgres.managed',
           'redis'

  requires 'setup osx apps installed'

  # Ruby versions with rbenv
  requires 'rbenv',
           '1.9.3.rbenv', '1.8.7.rbenv'

  requires 'node', 'npm'
end


dep 'setup osx apps installed' do
  # Social, Web, Media etc.
  requires 'Google Chrome.app',
           'Firefox.app',
           'Skype.app',
           'LimeChat.app',
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

  # Manual (No longer actively released)
  requires 'Navicat for PostgreSQL Lite.app',
           'Navicat for Oracle Lite.app'
end
