require "open3"
require "pry"
require "yaml"

class ConfigSettings
  def initialize
    @config = YAML.load_file("config.yml").map{ |k,v| [k.to_sym, v] }.to_h
  end 

  def zshrc_home_path
    "#{ENV["HOME"]}/.zshrc"
  end
  
  def zshrc_path
    "#{ENV["HOME"]}/#{@config[:DOTFILE_PATH]}/.zshrc"
  end

  def zsh_install_path
    @config[:ZSH_INSTALL_PATH]
  end

  def vimrc_home_path
    "#{ENV["HOME"]}/.vimrc"
  end
  
  def vimrc_path
    "#{ENV["HOME"]}/#{@config[:DOTFILE_PATH]}/.vimrc"
  end

  def vim_install_path
    @config[:VIM_INSTALL_PATH]
  end
end

conf = ConfigSettings.new

task default: :all
task :all => [:zsh_install, :vim_install]

task :zsh_install => [:zsh, :zsh_completions, conf.zshrc_path] do
  DefaultShellSetting.setting(conf.zsh_install_path)
end

task :vim_install => [conf.vimrc_path]


task :zsh do
  HomebrewInstall.install("zsh")
end

task :zsh_completions do
  HomebrewInstall.install("zsh-completions")
end

file conf.zshrc_path => '.zshrc' do
  cp '.zshrc', conf.zshrc_path
end

file conf.zshrc_path do
  sh("ln -fs #{conf.zshrc_path} #{conf.zshrc_home_path}")
end

file conf.vimrc_path => '.vimrc' do
  cp '.vimrc', conf.vimrc_path
end

file conf.vimrc_path do
  sh("ln -fs #{conf.vimrc_path} #{conf.vimrc_home_path}")
end

class  HomebrewInstall
  extend Rake::DSL
  def self.install(app)
    check(app) ? sh("brew install #{app}") : puts("skip install #{app}")
  end 
  def self.check(app)
    Open3.capture3("brew info #{app}")[0] =~ /Not installed/
  end 
end

class DefaultShellSetting
  ETC_SHELL="/etc/shell"

  extend Rake::DSL
  def self.setting(shell_pass)
    return if already_setting?(shell_pass)
    password = get_password
    sh("echo #{password} | sudo -S sh -c 'echo #{shell_pass} >> #{ETC_SHELL}}'")
    sh("chsh -s #{shell_pass}")
  end

  def self.already_setting?(shell_pass)
    /#{shell_pass}/ === File.open(ETC_SHELL).read
  end

  def self.get_password
    STDIN.noecho { Readline.readline("Password: ").tap{ puts } }
  end
end


