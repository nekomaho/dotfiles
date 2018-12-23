require "yaml"

class ConfigSettings
  attr_reader :dotfiles_dir,:src,:app,:vim_clone_path,:qfixhowm_path

  def initialize(input_config_file=nil)
    @input_config_file = input_config_file
    @dotfiles_dir = "#{home}/#{config[:DOTFILE_PATH]}"
    @src = "#{home}/src"
    @app = "#{home}/app"
    @vim_clone_path = "#{@src}/vim"
    @qfixhowm_path = "#{home}/.qfixhowm"
  end

  def zshrc_home_path
    "#{home}/.zshrc"
  end

  def zshrc_path
    "#{@dotfiles_dir}/.zshrc"
  end

  def zsh_install_path
    config[:ZSH_INSTALL_PATH]
  end

  def vimrc_home_path
    "#{home}/.vimrc"
  end

  def vimrc_path
    "#{@dotfiles_dir}/.vimrc"
  end

  def vim_install_path
    config[:VIM_INSTALL_PATH]
  end

  def tmux_home_path
    "#{home}/.tmux.conf"
  end

  def tmux_conf_path
    "#{@dotfiles_dir}/.tmux.conf"
  end

  def ctags_d_path
    "#{home}/.ctags.d"
  end

  def ctags_home_path
    "#{ctags_d_path}/default.ctags"
  end

  def ctags_path
    "#{@dotfiles_dir}/default.ctags"
  end

  private

  def home
    @home ||= "#{ENV["HOME"]}"
  end

  def config_file
    @config_file ||= @input_config_file || "config.yml"
  end

  def config
    @config ||= YAML.load_file(config_file).map{ |k,v| [k.to_sym, v] }.to_h
  end
end

