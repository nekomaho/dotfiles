module HomebrewInstallMock
  refine HomebrewInstall do
    def HomebrewInstall.install_or_upgrade(app)
      app
    end

    def HomebrewInstall.install(app)
      app
    end

    def HomebrewInstall.upgrade(app)
      app
    end
  end
end
