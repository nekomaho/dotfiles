require './spec/base'

RSpec.describe HomebrewInstall::RakeTaskGenerator do
  describe '.load' do
    subject { HomebrewInstall::RakeTaskGenerator.load }

    context 'exists setting yaml' do
      context 'yaml is correct gramar' do
        let(:expect_hash) do
          [vim: {}, 'universal-ctags': { install_name: "--HEAD universal-ctags/universal-ctags/universal-ctags" }, zsh: {}]
        end

        it 'load yaml setting to hash' do
          is_expected.to eq expect_hash
        end
      end
    end
  end
end
