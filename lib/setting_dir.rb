class SettingDir
  HOME = "#{ENV["HOME"]}".freeze
  DIRS = {
    dotfiles_dir:     "#{SettingDir::HOME}/.dotfiles",
    src:              "#{SettingDir::HOME}/src",
    app:              "#{SettingDir::HOME}/app",
    qfixhowm_path:    "#{SettingDir::HOME}/.qfixhowm",
    ctags_d_path:     "#{SettingDir::HOME}/.ctags.d",
    tmux_plugin_path: "#{SettingDir::HOME}/.tmux/plugins/tpm"
  }.freeze
end
