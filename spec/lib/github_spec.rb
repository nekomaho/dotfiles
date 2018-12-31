require './spec/base'

describe "Github test" do
  let(:github) { Githhub.new('rails/rails', protocol: 'git') }

  describe "#cd" do
    subject { github.cd('/hoge/hoge') }
    it { is_expected.to eq '/hoge/hoge' }
  end

  describe "#clone" do
    subject { github.clone }

    before do
      allow(github).to receive(:sh)
    end

    it do
      subject
      expect(github).to have_received(:sh).with('git clone git@github.com:rails/rails.git')
    end
  end
end
