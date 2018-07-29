require './spec/base'

describe "HomebrewInstall test" do
  before do
    allow(HomebrewInstall).to receive(:sh).and_return('install')
  end

  describe "#install" do
    before do
      allow(HomebrewInstall).to receive(:check).and_return(true)
    end

    it 'is retrun brew install app name' do
      expect(HomebrewInstall.install('dummy')).to eq('install')
    end
  end
end
