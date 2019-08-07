require 'io/console'
require 'readline'

class DefaultShellSetting
  ETC_SHELL="/etc/shells"

  def self.setting(shell_pass)
    return if already_setting?(shell_pass)
    password = get_password
    system("echo #{password} | sudo -S sh -c 'echo #{shell_pass} >> #{ETC_SHELL}'")
    system("chsh -s #{shell_pass}")
  end

  def self.already_setting?(shell_pass)
    /#{shell_pass}/ === File.open(ETC_SHELL).read
  end

  def self.get_password
    STDIN.noecho { Readline.readline("Password: ").tap{ puts } }
  end
end
