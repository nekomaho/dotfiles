require "./lib/setting_dir"
require "./lib/github"

module Tmux
  class PluginInstaller
    class << self
      def setup
        new.setup
      end
    end

    def setup
      puts 'stup tmux plugin'
      Github.new('tmux-plugins/tpm').yield_self do |github|
        github.clone_dir(SettingDir::DIRS[:tmux_plugin_path])
        github.clone
      end
    end
  end
end
