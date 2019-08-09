require "./lib/default_shell_settings"

module Zsh
  ZSH_INSTALL_PATH='/usr/local/bin/zsh'.freeze

  class ShellSetting
    class << self
      def set!
        new.set!
      end
    end

    def set!
      puts 'shell setting'
      DefaultShellSetting.setting(ZSH_INSTALL_PATH)
    end
  end
end
