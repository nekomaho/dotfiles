require './spec/base'

RSpec.describe HomebrewInstall::HomebrewTaskGenerator do
  describe '.load' do
    subject { HomebrewInstall::HomebrewTaskGenerator.load(tasks).tasks.to_h }

    context 'exists setting yaml' do
      context 'yaml is correct syntax' do
        let!(:tasks) do
          [
            {
              :hoge => {}
            },
            {
              :fuga => {}
            }
          ]
        end
        let(:expect_hash) { [{ hoge: {}}, {fuga: {}}] }

        it 'load yaml setting to hash' do
          is_expected.to eq expect_hash
        end
      end
    end
  end

  describe '.install_or_upgrade' do
    subject { HomebrewInstall::HomebrewTaskGenerator.load(tasks).install_or_upgrade }
    context 'when install' do
      let!(:tasks) do
        [
          {
            :hoge => {}
          },
          {
            :fuga => {}
          }
        ]
      end

      before do
        allow(HomebrewInstall).to receive(:install)
        allow(HomebrewInstall).to receive(:sh)
        allow(HomebrewInstall).to receive(:upgrade_check).and_return(true)
      end

      it 'received brew install' do
        subject
        expect(HomebrewInstall).to have_received(:sh).twice
#        expect(HomebrewInstall).to have_received(:sh).with('brew install hoge2').once
      end
    end

    context 'when update' do
    end
  end
end
