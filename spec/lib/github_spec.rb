require './spec/base'

describe "Github test" do
  describe "#clone_dir" do
    let(:github) { Github.new('rails/rails', protocol: :git) }

    subject { github.clone_dir('/hoge/hoge') }
    it { is_expected.to eq '/hoge/hoge' }
  end

  describe "#clone" do
    subject { github.clone }

    before do
      allow(github).to receive(:sh)
    end

    context "when direct clone_dir" do
      let(:github) { Github.new('rails/rails', protocol: :ssh, clone_dir: '/hoge/hoge') }

      it do
        subject
        expect(github).to have_received(:sh).with('git clone https://github.com/rails/rails /hoge/hoge')
      end
    end

    context "when not direct clone_dir" do
      let(:github) { Github.new('rails/rails', protocol: :git) }

      it do
        subject
        expect(github).to have_received(:sh).with('git clone git@github.com:rails/rails ')
      end
    end
  end
end
