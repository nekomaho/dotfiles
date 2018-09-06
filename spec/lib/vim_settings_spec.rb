require './spec/base'

describe 'VimInstall tests' do
  describe "#build" do
    subject(:build) {VimInstall.build('/vim/clone/path', '/vim/app/path')}

    before do
      allow(VimInstall).to receive(:sh)
      allow(VimInstall).to receive(:cd)
      allow(VimInstall).to receive(:vim_make)
    end

    it do
      subject
      expect(VimInstall).to have_received(:sh).with('git clone https://github.com/vim/vim.git /vim/clone/path')
      expect(VimInstall).to have_received(:cd).with('/vim/clone/path')
      expect(VimInstall).to have_received(:vim_make).with('/vim/app/path')
    end
  end
end
