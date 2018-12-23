require 'fileutils'
require './spec/base'
require './spec/helper/config_settings_helper'
require './spec/helper/vim_install_mock'

describe 'Rakefile tests' do

  include ConfigSettingHelper

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
    allow(HomebrewInstall).to receive(:install).and_return(true)
    allow(HomebrewInstall).to receive(:install_or_upgrade).and_return(true)
    allow(HomebrewInstall).to receive(:upgrade).and_return(true)

    allow(VimInstall).to receive(:update).and_return(true)
    allow(VimInstall).to receive(:build).and_return(true)
    allow(VimInstall).to receive(:install).and_return(true)
    allow(VimInstall).to receive(:dein).and_return(true)

    @rake.tasks.each do |task|
      task.reenable
    end
  end

  describe 'install all app task' do
    describe 'install all app dependency' do
      it 'is dependent make_dir, zsh_install, vim_install, ag_install, ctags_install, nodebrew, tmux' do
        expect(@rake['install'].sources).to include 'make_dir'
        expect(@rake['install'].sources).to include 'zsh_install'
        expect(@rake['install'].sources).to include 'vim_install'
        expect(@rake['install'].sources).to include 'ag_install'
        expect(@rake['install'].sources).to include 'ctags_install'
        expect(@rake['install'].sources).to include 'nodebrew'
        expect(@rake['install'].sources).to include 'tmux'
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

  describe 'install related ctags' do
    describe 'ctags install dependency' do
      it 'is dependent ctags' do
        expect(@rake['ctags_install'].sources).to include 'ctags'
        expect(@rake['ctags_install'].sources).to include "#{conf.ctags_home_path}"
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

  describe 'ctags install' do
    it 'is install ctags' do
      expect(@rake['ctags'].invoke[0].call).to eq '--HEAD universal-ctags/universal-ctags/universal-ctags'
    end
  end

  describe 'nodebrew install' do
     it 'is install nodebrew' do
      expect(@rake['nodebrew'].invoke[0].call).to eq 'nodebrew'
    end
  end

  describe 'tmux install' do
     it 'is install tmux' do
      expect(@rake['tmux'].invoke[0].call).to eq 'tmux'
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

    describe 'create symblic link to zashrc_home_path to zshrc_path' do
      before do
        FileUtils.touch(conf.zshrc_path)
      end

      after do
        File.delete(conf.zshrc_home_path)
        File.delete(conf.zshrc_path)
      end

      it 'is symbolic link of zshrc_path' do
        @rake[conf.zshrc_home_path].invoke
        expect(FileTest.symlink?(conf.zshrc_home_path)).to be_truthy
      end
    end

    describe 'copy vimrc to vimrc_path' do
      after do
        File.delete(conf.vimrc_path)
      end

      it 'is exist .vimrc to vimrc_path' do
        @rake[conf.vimrc_path].invoke
        expect(FileTest.exist?(conf.vimrc_path)).to be_truthy
      end
    end

    describe 'create symblic link to vimrc_home_path to vimrc_path' do
      before do
        FileUtils.touch(conf.vimrc_path)
      end

      after do
        File.delete(conf.vimrc_home_path)
        File.delete(conf.vimrc_path)
      end

      it 'is symbolic link of vimrc_path' do
        @rake[conf.vimrc_home_path].invoke
        expect(FileTest.symlink?(conf.vimrc_home_path)).to be_truthy
      end
    end

    describe 'copy tmux.conf to tmux_conf_path' do
      after do
        File.delete(conf.tmux_conf_path)
      end

      it 'is exist .tmux.conf to tmux_conf_path' do
        @rake[conf.tmux_conf_path].invoke
        expect(FileTest.exist?(conf.tmux_conf_path)).to be_truthy
      end
    end

    describe 'create symblic link to tmux_home_path to tmux_conf_path' do
      before do
        FileUtils.touch(conf.tmux_conf_path)
      end

      after do
        File.delete(conf.tmux_home_path)
        File.delete(conf.tmux_conf_path)
      end

      it 'is symbolic link of tmux_conf_path' do
        @rake[conf.tmux_home_path].invoke
        expect(FileTest.symlink?(conf.tmux_home_path)).to be_truthy
      end
    end

    describe 'copy ctags to tmux_conf_path' do
      after do
        File.delete(conf.ctags_path)
      end

      it 'is exist .ctags to ctags_path' do
        @rake[conf.ctags_path].invoke
        expect(FileTest.exist?(conf.ctags_path)).to be_truthy
      end
    end

    describe 'create symblic link to ctags_home_path to ctags_path' do
      before do
        FileUtils.touch(conf.ctags_path)
      end

      after do
        File.delete(conf.ctags_home_path)
        File.delete(conf.ctags_path)
      end

      it 'is symbolic link of ctags_path' do
        @rake[conf.ctags_home_path].invoke
        expect(FileTest.symlink?(conf.ctags_home_path)).to be_truthy
      end
    end
  end

  describe 'upgrade' do
    describe 'upgrade all app task' do
      describe 'upgrade all app dependency' do
        it 'is dependent make_dir, zsh_upgrade, vim_upgrade, ag_install, ctags_upgrade' do
          expect(@rake['upgrade:all'].sources).to include 'rake:make_dir'
          expect(@rake['upgrade:all'].sources).to include 'zsh_upgrade'
          expect(@rake['upgrade:all'].sources).to include 'vim_upgrade'
          expect(@rake['upgrade:all'].sources).to include 'rake:ag_install'
          expect(@rake['upgrade:all'].sources).to include 'ctags_upgrade'
          expect(@rake['upgrade:all'].sources).to include 'rake:nodebrew'
          expect(@rake['upgrade:all'].sources).to include 'rake:tmux'
        end
      end
    end

    describe 'upgrade related zsh' do
      describe 'zsh upgrade dependency' do
        it 'is dependent zsh, zsh_completions, .zshrc' do
          expect(@rake['upgrade:zsh_upgrade'].sources).to include 'rake:zsh'
          expect(@rake['upgrade:zsh_upgrade'].sources).to include 'rake:zsh_completions'
          expect(@rake['upgrade:zsh_upgrade'].sources).to include "#{conf.zshrc_home_path}"
        end
      end
    end

    describe 'upgrade ctags' do
      describe 'ctags upgrade dependency' do
        it 'is dependent ctags' do
          expect(@rake['upgrade:ctags_upgrade'].sources).to include "#{conf.ctags_home_path}"
          expect(@rake['upgrade:ctags_upgrade'].invoke[0].call).to eq 'universal-ctags'
        end
      end
    end

    describe 'dein upgrade' do
      describe 'dein upgrade dependency' do
        it 'is dependent vim' do
          expect(@rake['upgrade:dein_upgrade'].sources).to include 'vim'
        end
      end

      describe 'dein main upgrade task' do
        describe 'dein upgrade when update' do
          before do
            # only test this task not dependency task
            @rake['upgrade:dein_upgrade'].clear_prerequisites
          end

          it 'is install dein' do
            expect(@rake['upgrade:dein_upgrade'].invoke[0].call).to eq "#{conf.dotfiles_dir}"
          end
        end
      end
    end

    describe 'vim upgrade' do
      describe 'vim upgrade dependency' do
        it 'is dependent .vimrc and lua' do
          expect(@rake['upgrade:vim'].sources).to include "#{conf.vimrc_home_path}"
          expect(@rake['upgrade:vim'].sources).to include 'rake:lua'
        end
      end

      describe 'vim main upgrade task' do
        before do
          # only test this task not dependency task
          @rake['upgrade:vim'].clear_prerequisites
        end

        describe 'vim upgrade when update' do
          it 'is update vim' do
            allow(File).to receive(:exist?).and_return(true)
            expect(@rake['upgrade:vim'].invoke[0].call).to eq "#{conf.vim_clone_path}"
          end
        end

        describe 'vim upgrade when install' do
          it 'is build  vim' do
            allow(File).to receive(:exist?).and_return(false)
            expect(@rake['upgrade:vim'].invoke[0].call).to eq "#{conf.vim_clone_path}"
          end
        end
      end
    end
  end
end
