require_relative '../lib/dark_trader.rb'

# Test si la page est bien récupéré par nokogiri et open-uri
describe "the url_main_path method" do
  it "should not be nil" do
    expect(url_main_path).not_to be_nil
  end
end

# Test si le programme renvoie des données correctes
describe "the get_cryptocurrencies method" do
  it "should return a hash" do
    expect(get_cryptocurrencies).to be_an_instance_of(Hash)
  end

  it "should contain some cryptocurrencies names" do
    expect(get_cryptocurrencies).to have_key("Bitcoin")
    expect(get_cryptocurrencies).to have_key("Ethereum")
  end

  it "should contain about 200 cryptocurrencies" do
    expect(get_cryptocurrencies.length).to be > 180
    expect(get_cryptocurrencies.length).to be < 220
  end
end