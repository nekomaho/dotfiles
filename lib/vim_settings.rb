require "./lib/src_install.rb"

class  VimInstall
  extend SrcInstall
  extend Rake::DSL 

  VIM_GIT_URL='https://github.com/vim/vim.git'
  DEIN_GIT_URL='https://github.com/Shougo/dein.vim'

  def self.build(clone_path, app_path)
    sh("git clone #{VIM_GIT_URL} #{clone_path}")
    cd clone_path
    vim_make(app_path)
  end
  
  def self.install(clone_path)
    cd clone_path
    make_install 
  end

  def self.test(clone_path)
    cd clone_path
    make_test
  end

  def self.update(clone_path, app_path)
    cd clone_path
    sh("git pull")
    make_clean
    vim_make(app_path)
  end

  def self.dein(clone_path, app_path)
    if File.exists?(clone_path)
      cd clone_path+'/dein'
      sh("git pull")
    else
      sh("git clone #{DEIN_GIT_URL} #{clone_path}/dein")
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
end
