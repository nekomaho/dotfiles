require 'fileutils'

module SrcInstall
  def make
    system('make')
  end

  def make_test
    system('make test')
  end

  def make_install
    system("make install")
  end

  def make_clean
    system("make clean")
  end

  def configure(option)
    system("./configure #{option}")
  end
end
