require './spec/base'

describe "ConfigSettings test" do
  let(:config) { ConfigSettings.new("spec/lib/yml/dummy.yml") }

  describe "#zshrc_home_path" do
    it 'is retrun .zshrc path' do
      expect(config.zshrc_home_path).to eq("#{ENV["HOME"]}/.zshrc")
    end
  end

  describe "#zshrc_path" do
    it 'is return user use zshrc path' do
      expect(config.zshrc_path).to eq("#{ENV["HOME"]}/.dotfiles/.zshrc")
    end
  end

  describe "#zsh_install_path" do
    it 'is return zsh install path' do
      expect(config.zsh_install_path).to eq("/usr/bin/local/zsh")
    end
  end

  describe "#vimrc_home_path" do
    it 'is return vimrc home path' do
      expect(config.vimrc_home_path).to eq("#{ENV["HOME"]}/.vimrc")
    end
  end

  describe "#vimrc_path" do
    it 'is return vimrc path' do
      expect(config.vimrc_path).to eq("#{ENV["HOME"]}/.dotfiles/.vimrc")
    end
  end

  describe "#vim_install_path" do
    it 'is return vim install path' do
      expect(config.vim_install_path).to eq("/Users/hoge/app/bin/vim")
    end
  end

  describe "#tmux_home_path" do
    it 'is return tmux home path' do
      expect(config.tmux_home_path).to eq("#{ENV["HOME"]}/.tmux.conf")
    end
  end

  describe "#tmux_conf_path" do
    it 'is return tmux path' do
      expect(config.tmux_conf_path).to eq("#{ENV["HOME"]}/.dotfiles/.tmux.conf")
    end
  end

  describe "#ctags_home_path" do
    it 'is return ctags home path' do
      expect(config.ctags_home_path).to eq("#{ENV["HOME"]}/.ctags.d/default.ctags")
    end
  end

  describe "#ctags_conf_path" do
    it 'is return ctags path' do
      expect(config.ctags_path).to eq("#{ENV["HOME"]}/.dotfiles/default.ctags")
    end
  end

  describe "#ag_ignore_home_path" do
    it 'is return ag_ignore_home_path' do
      expect(config.ag_ignore_home_path).to eq("#{ENV["HOME"]}/.agignore")
    end
  end

  describe "#ag_ignore_path" do
    it 'is return ag_ignore_path' do
      expect(config.ag_ignore_path).to eq("#{ENV["HOME"]}/.dotfiles/.agignore")
    end
  end
end
