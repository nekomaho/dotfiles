module VimInstallMock
  refine VimInstall do
    class << VimInstall
      def update(path, app)
        'update'
      end

      def build(path, app)
        'build'
      end

      def install(path)
        path
      end

      def dein(path, app)
        path
      end
    end
  end
end
