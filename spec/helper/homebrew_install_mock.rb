module HomebrewInstallMock
  refine HomebrewInstall do
    def HomebrewInstall.install_or_upgrade(app)
      app
    end
  end
end
