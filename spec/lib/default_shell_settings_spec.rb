require './spec/base'

describe 'DefaultShellSetting tests' do
  describe "#setting" do
    subject(:setting) {DefaultShellSetting.setting('/dummy/pass')}
 
    context "when need setting" do
      before do
        allow(DefaultShellSetting).to receive(:sh)
        allow(DefaultShellSetting).to receive(:get_password).and_return('password')
        allow(DefaultShellSetting).to receive(:already_setting?).and_return(false)
      end

      it do
        subject
        expect(DefaultShellSetting).to have_received(:sh).with('echo password | sudo -S sh -c \'echo /dummy/pass >> /etc/shells\'').once
        expect(DefaultShellSetting).to have_received(:sh).with('chsh -s /dummy/pass').once
      end
    end

    context "when already done setting" do
      before do
        allow(DefaultShellSetting).to receive(:get_password)
        allow(DefaultShellSetting).to receive(:already_setting?).and_return(true)
      end

      it do
        subject
        expect(DefaultShellSetting).not_to have_received(:get_password)
      end
    end
  end
end
