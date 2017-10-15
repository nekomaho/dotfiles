require "open3"
require "pry"
require "yaml"

config = YAML.load_file("config.yml").map{ |k,v| [k.to_sym, v] }.to_h
task default: :all
task :all => [:zsh_install]

task :zsh_install => [:zsh, :zsh_completions, :dot_zshrc] do
  binding.pry
  DefaultShellSetting.setting(config[:ZSH_INSTALL_PATH])
end

task :zsh do
  HomebrewInstall.install("zsh")
end

task :zsh_completions do
  HomebrewInstall.install("zsh-completions")
end

task :dot_zshrc do

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
    binding.pry
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


