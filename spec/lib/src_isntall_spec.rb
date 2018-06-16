require './spec/base'

describe "SrcInstall test" do
  before do
    extend SrcInstall
    def sh(command)
      command
    end
  end

  describe "#make" do
    it 'is retrun make' do
      expect(make).to eq('make')
    end
  end

  describe "#make_test" do
    it 'is retrun make test' do
      expect(make_test).to eq('make test')
    end
  end

  describe "#make_install" do
    it 'is retrun make install' do
      expect(make_install).to eq('make install')
    end
  end

  describe "#make_clean" do
    it 'is retrun make clean' do
      expect(make_clean).to eq('make clean')
    end
  end

  describe "#configure" do
    it 'is retrun configure' do
      expect(configure('hoge=true')).to eq('./configure hoge=true')
    end
  end
end
