# Usage:
# [install rbenv like normal] https://github.com/sstephenson/rbenv
# babushka 1.9.3.rbenv
# rbenv global 1.9.3-rc1
# rbenv rehash

#Required to run 'rbenv install' commands for patches
dep 'ruby-build.managed' do
  installs {
    via :brew, 'ruby-build'
  }
  provides []
end

dep 'yaml-headers.managed' do
  installs {
    via :brew, 'libyaml'
    via :apt, 'libyaml-dev'
  }
  provides []
end

#Mountain lion installs of /usr/bin/gcc symlinks to llvm-gcc-4.2 which is not sufficient for older ruby installs
#lrwxr-xr-x     1 root   wheel        12 26 Sep 21:09 gcc -> llvm-gcc-4.2
dep 'gcc-for-mountain-lion.installer' do
  #Get latest from https://github.com/kennethreitz/osx-gcc-installer
  source 'https://github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg'

  met? {
    File.exists?('/usr/bin/gcc-4.2') 
  }
end

dep 'rbenv' do
  met? {
    in_path? 'rbenv'
  }
  meet {
    git 'https://github.com/sstephenson/rbenv.git', :to => '~/.rbenv'
  }
end

dep 'set-global-rbenv-version' do
  met? {
    shell('cat ~/.rbenv/version').to_s == "1.9.3-p194-perf"
  }
  meet {
    shell 'rbenv global 1.9.3-p194-perf'
  }
end

meta :rbenv do
  accepts_value_for :version, :basename
  accepts_value_for :patchlevel
  accepts_block_for :customise
  template {
    def version_spec
      "#{version}-#{patchlevel}"
    end
    def ruby_prefix
      "~/.rbenv/versions" / version_spec
    end
    def version_group
      version.scan(/^\d\.\d/).first
    end
    requires 'rbenv', 'yaml-headers.managed', 'gcc-for-mountain-lion.installer'
    met? {
      (ruby_prefix / 'bin/ruby').executable? and
      shell(ruby_prefix / 'bin/ruby -v')[/^ruby #{version}#{patchlevel}\b/]
    }
    meet {
      yaml_location = shell('brew info libyaml').split("\n").collapse(/\s+\(\d+ files, \S+\)/).first
      handle_source "http://ftp.ruby-lang.org/pub/ruby/#{version_group}/ruby-#{version_spec}.tar.gz" do |path|
        invoke(:customise)
        log_shell 'Configure', "./configure --prefix='#{ruby_prefix}' --with-libyaml-dir='#{yaml_location}' CC=/usr/bin/gcc-4.2"
        log_shell 'Build',     "make -j#{Babushka.host.cpus}"
        log_shell 'Install',   "make install"

        # ruby-1.9.2 doesn't install bin/* when the build path contains a dot-dir.
        shell "cp bin/* #{ruby_prefix / 'bin'}"
      end
    }
    after {
      log_shell 'rbenv rehash', 'rbenv rehash'
    }
  }
end

dep '1.9.3.rbenv' do
  patchlevel 'p194'
end

dep '1.9.3-p194-perf.rbenv' do
  requires 'ruby-build.managed' #Required for `rbenv install`

  version      '1.9.3'
  patchlevel   'p194'

  customise {
    shell "curl https://raw.github.com/gist/2600122/rbenv.sh | sh "
  }
end
