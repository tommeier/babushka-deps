#TODO : Clean up Documents/Pictures
#TODO : Backup ~/Library (Application Support + Preference)
#TODO : Backup entire user directory ~/

###Browsers###

dep 'Google Chrome.app' do
  source 'https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
end

dep 'Firefox.app' do
  source 'http://www.mozilla.org/en-US/products/download.html?product=firefox-15.0.1&os=osx&lang=en-US'
end

###Utilities###

dep '1Password.app' do
  source 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac/1Password-3.8.20.zip'
end

dep 'Things.app' do
  source 'http://culturedcode.com/things/download/'
end

dep 'UnRarX.app' do
  source 'http://www.unrarx.com/files/UnRarX_2.2.zip'
end

dep 'Dropbox.app' do
  source 'https://www.dropbox.com/download?plat=mac'
end

dep 'iStumbler.app' do
  source 'http://istumbler.net/downloads/istumbler-99.zip'
end

dep 'iStat Menus.app' do
  sparkle 'http://bjango.com/istatmenus/appcast/appcast.xml'
end

dep 'Automatic.prefpane' do
  source 'http://codingcurious.com/downloads/Automatic.2.zip'
end

###Dev tools###

dep 'iTerm.app' do
  sparkle 'http://iterm2.googlecode.com/svn/trunk/appcasts/final.xml'
end

dep 'Localghost.app' do
  source 'http://cloud.github.com/downloads/scotchi/Localghost/Localghost-1.0.dmg'
end


dep 'Sublime Text 2.app' do
  sparkle 'http://www.sublimetext.com/updates/2/stable/appcast_osx.xml'
end

dep 'Sublime Text 2.configured' do
  requires 'Sublime Text 2.app'
  met? { File.exists?('/usr/local/bin/subl') }
  meet {     cd('/usr/local/bin') {|path|
      shell 'ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" .', :sudo => !path.writable?
    }
  }
end

dep 'VirtualBox.app' do
  source 'http://download.virtualbox.org/virtualbox/4.2.0/VirtualBox-4.2.1-80871-OSX.dmg'
end


###Net Comms Apps###

dep 'Skype.app' do
  source 'http://www.skype.com/go/getskype-macosx.dmg'
end

dep 'NetNewsWire.app' do
  source 'http://netnewswireapp.com/downloads/NetNewsWire.zip'
end

###Media###

dep 'PS3 Media Server.app' do
  source 'https://ps3mediaserver.googlecode.com/files/pms-macosx-1.70.1.dmg'
end

dep 'Transmission Remote GUI.app' do
  source 'http://code.google.com/p/transmisson-remote-gui/downloads/detail?name=transgui-4.0.3.dmg'
end

dep 'VLC.app' do
  source 'http://downloads.sourceforge.net/project/vlc/2.0.3/macosx/vlc-2.0.3.dmg?r=http%3A%2F%2Fwww.videolan.org%2F&ts=1348627934&use_mirror=aarnet'
end

###Manually saved (no longer released)###
dep 'Navicat for PostgreSQL Lite.app' do
  source 'https://www.dropbox.com/s/4mozn08qw6tz78g/Navicat%20for%20PostgreSQL%20Lite.app.zip'
end

dep 'Navicat for Oracle Lite.app' do
  source 'https://www.dropbox.com/s/r689xysc5keyfll/Navicat%20for%20Oracle%20Lite.app.zip'
end


### Install on app store
# Xcode
# 3Hub.app (appstore)
# Trillian.app (appstore)
# Caffeine.app (app store)
# The Unarchiver.app (app store)
# Twitter.app
# LimeChat.app

#Download manually
#PeepOpen.app
#http://codingcurious.com/downloads/Automatic.2.zip? -> Prefpane



