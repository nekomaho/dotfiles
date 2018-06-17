require './spec/base'
require './spec/helper/config_settings_helper'
require './spec/helper/homebrew_install_mock'
require './spec/helper/vim_install_mock'

describe 'Rakefile tests' do

  # mock for rack test
  include ConfigSettingHelper
  using HomebrewInstallMock
  using VimInstallMock

  let(:conf) { ConfigSettings.new }

  before(:all) do
    test_config_setting
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.raw_load_rakefile
  end

  after(:all) do
    config_setting_teardown
  end

  before(:each) do
    @rake.tasks.each do |task|
      task.reenable
    end
  end

  describe 'install all app task' do
    describe 'install all app dependency' do
      it 'is dependent make_dir, zsh_install, vim_install, ag_install, global_install' do
        expect(@rake['install'].sources).to include 'make_dir'
        expect(@rake['install'].sources).to include 'zsh_install'
        expect(@rake['install'].sources).to include 'vim_install'
        expect(@rake['install'].sources).to include 'ag_install'
        expect(@rake['install'].sources).to include 'global_install'
      end
    end
  end

  describe 'install related zsh' do
    describe 'zsh install dependency' do
      it 'is dependent zsh, zsh_completions, .zshrc' do
        expect(@rake['zsh_install'].sources).to include 'zsh'
        expect(@rake['zsh_install'].sources).to include 'zsh_completions'
        expect(@rake['zsh_install'].sources).to include "#{conf.zshrc_home_path}"
      end
    end
  end

  describe 'install related global' do
    describe 'global install dependency' do
      it 'is dependent global, exuberant_ctags and pygments' do
        expect(@rake['global_install'].sources).to include 'global'
        expect(@rake['global_install'].sources).to include 'exuberant_ctags'
        expect(@rake['global_install'].sources).to include 'pygments'
      end
    end
  end

  describe 'dein install' do
    describe 'dein install dependency' do
      it 'is dependent vim' do
        expect(@rake['dein'].sources).to include 'vim'
      end
    end

    describe 'dein main install task' do
      describe 'dein install when update' do
        before do
          # only test this task not dependency task
          @rake['dein'].clear_prerequisites
        end

        it 'is install dein' do
          expect(@rake['dein'].invoke[0].call).to eq "#{conf.dotfiles_dir}"
        end
      end
    end
  end

  describe 'vim install' do
    describe 'vim install dependency' do
      it 'is dependent .vimrc and lua' do
        expect(@rake['vim'].sources).to include "#{conf.vimrc_home_path}"
        expect(@rake['vim'].sources).to include 'lua'
      end
    end

    describe 'vim main install task' do
      before do
        # only test this task not dependency task
        @rake['vim'].clear_prerequisites
      end

      describe 'vim install when update' do
        it 'is update vim' do
          allow(File).to receive(:exist?).and_return(true)
          expect(@rake['vim'].invoke[0].call).to eq "#{conf.vim_clone_path}"
        end
      end

      describe 'vim install when install' do
        it 'is build  vim' do
          allow(File).to receive(:exist?).and_return(false)
          expect(@rake['vim'].invoke[0].call).to eq "#{conf.vim_clone_path}"
        end
      end
    end
  end

  describe 'ag install' do
    it 'is install ag' do
      expect(@rake['ag_install'].invoke[0].call).to eq 'the_silver_searcher'
    end
  end

  describe 'zsh install' do
    it 'is install zsh' do
      expect(@rake['zsh'].invoke[0].call).to eq 'zsh'
    end

    describe 'zsh completions install' do
      it 'is install zsh' do
        expect(@rake['zsh_completions'].invoke[0].call).to eq 'zsh-completions'
      end
    end
  end

  describe 'lua install' do
    it 'is install lua' do
      expect(@rake['lua'].invoke[0].call).to eq 'lua'
    end
  end

  describe 'global install' do
    it 'is install global' do
      expect(@rake['global'].invoke[0].call).to eq 'global'
    end
  end

  describe 'ctags install' do
    it 'is install ctags' do
      expect(@rake['exuberant_ctags'].invoke[0].call).to eq 'exuberant-ctags'
    end
  end

  describe 'pygments install' do
     it 'is install pygments' do
      expect(@rake['pygments'].invoke[0].call).to eq 'pygments'
    end
  end

  describe 'make directory' do
    describe 'make directory dependency' do
      it 'is dotfiles_dir, conf.src, conf.app, conf.fixhowm' do
        expect(@rake['make_dir'].sources).to include "#{conf.dotfiles_dir}"
        expect(@rake['make_dir'].sources).to include "#{conf.src}"
        expect(@rake['make_dir'].sources).to include "#{conf.app}"
        expect(@rake['make_dir'].sources).to include "#{conf.qfixhowm_path}"
      end
    end
  end

  describe 'file task' do
    describe 'copy zshrc to zshrc_path' do
      after do
        File.delete(conf.zshrc_path)
      end

      it 'is exist .zshrc to zshrc_path' do
        @rake[conf.zshrc_path].invoke
        expect(FileTest.exist?(conf.zshrc_path)).to be_truthy
      end
    end
  end
end
