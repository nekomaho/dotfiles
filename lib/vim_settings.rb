require 'fileutils'
require "./lib/src_install.rb"

class  VimInstall
  extend SrcInstall

  VIM_GIT_URL='https://github.com/vim/vim.git'
  DEIN_GIT_URL='https://github.com/Shougo/dein.vim'

  def self.build(clone_path, app_path)
    system("git clone #{VIM_GIT_URL} #{clone_path}")
    current_path = FileUtils.pwd
    FileUtils.cd clone_path
    vim_make(app_path)
    FileUtils.cd current_path
    install(clone_path)
  end
 
  def self.install(clone_path)
    current_path = FileUtils.pwd
    FileUtils.cd clone_path
    make_install
    FileUtils.cd current_path
  end

  def self.test(clone_path)
    current_path = FileUtils.pwd
    FileUtils.cd clone_path
    make_test
    FileUtils.cd current_path
  end

  def self.update(clone_path, app_path)
    current_path = FileUtils.pwd
    FileUtils.cd clone_path
    if git_pull_with_already_up_to_date_check
      puts "Already installed newest vim"
      FileUtils.cd current_path
      return
    end
    make_clean
    vim_make(app_path)
    FileUtils.cd current_path
    install(clone_path)
  end

  def self.dein(clone_path, app_path)
    dein_clone_path =  clone_path+'/dein'
    if File.exists?(dein_clone_path)
      current_path = FileUtils.pwd
      FileUtils.cd dein_clone_path
      git_pull_with_already_up_to_date_check
      FileUtils.cd current_path
    else
      system("git clone #{DEIN_GIT_URL} #{dein_clone_path}")
    end
  end

  def self.vim_make(app_path)
    config_str = "--prefix=#{app_path}"\
      " --enable-luainterp=yes"\
      " --enable-rubyinterp=yes"\
      " --enable-multibyte"\
      " --enable-terminal"\
      " --enable-darwin"\
      " --enable-python3interp=dynamic"\
      " --enable-pythoninterp=dynamic"\
      " --with-lua-prefix=/usr/local"
    configure(config_str)
    make
  end

  def self.git_pull_with_already_up_to_date_check
    Open3.capture3("git pull")[0] =~ /Already up to date/
  end
end
