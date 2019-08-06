require 'fileutils'

module SrcInstall
  def make
    exec("make")
  end

  def make_test
    exec("make test")
  end

  def make_install
    exec("make install")
  end

  def make_clean
    exec("make clean")
  end

  def configure(option)
    exec("./configure #{option}")
  end
end
