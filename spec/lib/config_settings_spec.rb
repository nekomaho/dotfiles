require './lib/config_settings'

describe "zshrc_home_path" do
  let(:config) { ConfigSettings.new }
  it 'is retrun .zshrc path' do
    expect(config.zshrc_home_path).to  eq("#{ENV["HOME"]}/.zshrc")
  end
end
