module SrcInstall
  def make
    sh("make")
  end

  def make_test
    sh("make test")
  end

  def make_install
    sh("make install")
  end

  def make_clean
    sh("make clean")
  end

  def configure(option)
    sh("./configure #{option}")
  end
end
