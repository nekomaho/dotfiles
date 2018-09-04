require './spec/base'

describe 'Homebrew install tests' do
  describe "#install" do
    subject(:install) {HomebrewInstall.install('dummy')}
 
    context "when need install" do
      before do
        allow(HomebrewInstall).to receive(:sh)
        allow(HomebrewInstall).to receive(:check).and_return(true)
      end

      it do
        subject
        expect(HomebrewInstall).to have_received(:sh).with('brew install dummy')
      end
    end

    context "when do not need install" do
      before do
        allow(HomebrewInstall).to receive(:puts)
        allow(HomebrewInstall).to receive(:check).and_return(false)
      end

      it do
        subject
        expect(HomebrewInstall).to have_received(:puts).with('skip install dummy')
      end
    end
  end

  describe "#check" do
    subject(:check) { HomebrewInstall.check('dummy') }

    describe "when not installed application" do
      before do
        allow(Open3).to receive(:capture3).and_return(["Not installed dummy"])
      end

      it { is_expected.to be_truthy }
    end

    describe "when installed application" do
      before do
        allow(Open3).to receive(:capture3).and_return(["dummy"])
      end

      it { is_expected.to be_falsy }
    end
  end

  describe "#upgrade" do
    subject(:upgrade){ HomebrewInstall.upgrade('dummy') }

    context "when need upgrade" do
      before do
        allow(HomebrewInstall).to receive(:sh)
        allow(HomebrewInstall).to receive(:upgrade_check).and_return(true)
      end

      it do
        subject
        expect(HomebrewInstall).to have_received(:sh).with('brew upgrade dummy')
      end
    end

    context "when do not need upgrade" do
      before do
        allow(HomebrewInstall).to receive(:puts)
        allow(HomebrewInstall).to receive(:upgrade_check).and_return(false)
      end

      it do
        subject
        expect(HomebrewInstall).to have_received(:puts).with('skip upgrade dummy')
      end
    end
  end
end
