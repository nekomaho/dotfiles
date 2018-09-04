require './spec/base'

describe 'Homebrew install tests' do
  describe "#install" do
    before do
      allow(HomebrewInstall).to receive(:sh)
      allow(HomebrewInstall).to receive(:check).and_return(true)
    end

    it do
      HomebrewInstall.install('dummy')
      expect(HomebrewInstall).to have_received(:sh).with('brew install dummy')
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
end
