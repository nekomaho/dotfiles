require './lib/default_shell_settings'
require './spec/base'

describe "DefaultShellSetting test" do
  before do
    extend SrcInstall
    def sh(command)
      command
    end
  end

  describe ".setting" do
  end

  describe "already_setting?" do
    before do
      DefaultShellSetting::ETC_SHELL = 'spec/lib/fixture/shell_dummy'
    end

    describe "when exists pass in shell file" do
      it 'is return true' do
        expect(DefaultShellSetting.already_setting?('/hoge/hoge')).to be true
      end
    end

    describe "when exists pass not in shell file" do
      it 'is retrun false' do
        expect(DefaultShellSetting.already_setting?('/hoge/one')).to be false
      end
    end
  end

  describe "get_password" do
  end
end
