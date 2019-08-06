require "pry"
require "./lib/config_settings"
require "./lib/homebrew_install"
require "./lib/default_shell_settings"
require "./lib/vim_settings.rb"
require "./lib/github.rb"

conf = ConfigSettings.new

desc 'install all'
task default: :install

desc 'install each application'
task :install => [:zsh_install, :vim_install, :ag_install, :ctags_install, :nodebrew, :tmux_install]

desc 'install related zsh'
task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_home_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

desc 'insatll releated vim'
task :vim_install => [:dein]

desc 'insatll related ctags'
task :ctags_install => [:ctags, conf.ctags_home_path]

desc 'insatll related tmux'
task :tmux_install => [:tmux_plugin, :tmux]

desc 'install dein that plugin of vim'
task :dein => [:vim] do
  VimInstall.dein(conf.dotfiles_dir,conf.app)
end

desc 'install vim'
task :vim => [conf.vimrc_home_path, :lua ] do
  if File.exists?(conf.vim_clone_path)
    VimInstall.update(conf.vim_clone_path,conf.app)
  else
    VimInstall.build(conf.vim_clone_path,conf.app)
  end
end

desc 'install relaated silver bullet(ag)'
task :ag_install => [conf.ag_ignore_home_path] do
end

desc 'install tmux-plugin'
task :tmux_plugin  => :tmux do
  unless Dir.exists?(conf.tmux_plugin_path)
    Github.new('tmux-plugins/tpm').yield_self do |github|
      github.clone_dir(conf.tmux_plugin_path)
      github.clone
    end
  end
end

desc 'install tmux'
task :tmux  => [conf.tmux_home_path ] do
end

desc 'install nodebrew'
task :nodebrew do
end

desc 'install lua that need vim'
task :lua do
end

desc 'install zsh'
task :zsh do
end

desc 'install zsh_completions'
task :zsh_completions do
end

desc 'insall ctags that source code tagging system'
task :ctags do
end

file conf.zshrc_home_path => conf.zshrc_path

file conf.zshrc_path => '.zshrc'

file '.zshrc'

file conf.vimrc_home_path => conf.vimrc_path

file conf.vimrc_path => '.vimrc'

file '.vimrc'

file conf.ctags_home_path => conf.ctags_path

file conf.ctags_path => 'default.ctags'

file 'default.ctags'

file conf.tmux_home_path => conf.tmux_conf_path

file conf.tmux_conf_path => '.tmux.conf'

file '.tmux.conf'

file conf.ag_ignore_home_path => conf.ag_ignore_path

file conf.ag_ignore_path => '.agignore' do

file '.agignore'


namespace :upgrade do
  desc 'upgrade all application'
  task :all => ["rake:make_dir", :zsh_upgrade, :vim_upgrade, "rake:ag_install", :ctags_upgrade, "rake:nodebrew", "rake:tmux_install"]

  desc 'upgrade zsh releated application'
  task :zsh_upgrade => ["rake:zsh", "rake:zsh_completions", conf.zshrc_home_path] do
    DefaultShellSetting.setting(conf.zsh_install_path)
  end

  desc 'upgrade vim releated application'
  task :vim_upgrade => [:dein_upgrade]

  desc 'upgrade ctags application'
  task :ctags_upgrade => [conf.ctags_home_path] do
  end

  desc 'upgrade dein that plugin of vim'
  task :dein_upgrade => [:vim] do
    VimInstall.dein(conf.dotfiles_dir,conf.app)
  end

  desc 'upgrade vim releated application'
  task :vim => [conf.vimrc_home_path, "rake:lua" ] do
    if File.exists?(conf.vim_clone_path)
      VimInstall.update(conf.vim_clone_path,conf.app)
    else
      VimInstall.build(conf.vim_clone_path,conf.app)
    end
  end
end
