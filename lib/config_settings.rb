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

