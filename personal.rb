dep 'development_dir' do
  met? {
    (ENV['HOME'] / "development").dir? && (ENV['HOME'] / "development" / "projects").dir?
  }

  meet {
    log_shell "Make ~/development/projects", 'mkdir -p ~/development/projects'
  }
end

meta 'project_dir' do
  accepts_value_for :target, :basename

  template {
    def directory_name
     target.to_s.gsub(/^directory\-/, '')
    end

    met? { (ENV['HOME'] / "development" / "projects" / directory_name).dir? }
    meet {
      log_shell "Make ~/development/projects/#{directory_name}", "mkdir -p ~/development/projects/#{directory_name}"
    }
  }
end

dep 'directory-archived', :template => 'project_dir'
dep 'directory-current',  :template => 'project_dir'
dep 'directory-company',  :template => 'project_dir'
dep 'directory-family',   :template => 'project_dir'

dep 'publish-to-script' do
  met? {
    "#{ENV['HOME']}/development/scripts/bash-publish_to/.git".p.dir?
  }
  meet {
    log_shell "Cloning publish script", "git clone git@github.com:tommeier/bash-publish_to.git #{ENV['HOME']}/development/scripts/bash-publish_to"
  }
end

meta 'dotfiletemplate' do
  accepts_value_for :repo, :basename
  accepts_value_for :target, :basename

  template {
    met? { "#{ENV['HOME']}/development/projects/personal/#{target}/.git".p.dir? }
    meet {
      log_shell "Cloning", "git clone git@github.com:tommeier/#{repo}.git #{ENV['HOME']}/development/projects/personal/#{target}"
      log_shell "Symlinking", "cd #{ENV['HOME']}/development/projects/personal/#{target} && rake install"
    }
  }
end

dep 'dotfiles', :template => 'dotfiletemplate'
dep 'private-dotfiles', :template => 'dotfiletemplate'
