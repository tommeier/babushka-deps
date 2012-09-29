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
    shell('cat ~/.rbenv/version')[/^#{Regexp.escape('1.9.3-p194-perf')}/]
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
    requires 'rbenv', 'yaml-headers.managed'
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
