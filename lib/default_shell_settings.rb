class DefaultShellSetting
  ETC_SHELL="/etc/shells"

  extend Rake::DSL
  def self.setting(shell_pass)
    return if already_setting?(shell_pass)
    password = get_password
    sh("echo #{password} | sudo -S sh -c 'echo #{shell_pass} >> #{ETC_SHELL}'")
    sh("chsh -s #{shell_pass}")
  end

  def self.already_setting?(shell_pass)
    /#{shell_pass}/ === File.open(ETC_SHELL).read
  end

  def self.get_password
    STDIN.noecho { Readline.readline("Password: ").tap{ puts } }
  end
end


