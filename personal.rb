dep 'development_dir' do
  met? {
    (ENV['HOME'] / "development" / "projects").dir?
  }

  meet {
    log_shell "Make ~/development/projects", 'mkdir ~/development/projects'
  }
end

meta 'project_dir' do
  accepts_value_for :target, :basename

  template {
    met? { (ENV['HOME'] / "development" / "projects" / target).dir? }
    meet {
      log_shell "Make ~/development/projects/#{target}", 'mkdir ~/development/projects/#{target}'
    }
  }
end

dep 'archived', :template => 'project_dir'
dep 'current',  :template => 'project_dir'
dep 'company',  :template => 'project_dir'
dep 'family',   :template => 'project_dir'


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
