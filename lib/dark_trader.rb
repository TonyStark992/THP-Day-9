require 'pry'
require 'nokogiri'
require 'open-uri'

# Méthode qui wrap la page html et accède au tableau des cryptomonnaies
def url_main_path
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  table_path = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table')
end

# Méthode qui récupère tous les noms des crypto
def get_crypto_names (table_path)
  crypto_names = table_path.xpath('//div[contains(@class,"column-name")]//a').map {|name| name.text}
end

# Méthode qui récupère tous les cours des crypto
def get_crypto_values (table_path)
  crypto_values = table_path.xpath('//td[contains(@class,"by__price")]//a').map {|price| price.text}
end

# Méthode principale : fournie un hash avec toutes les cryptos du site (nom => cours)
def get_cryptocurrencies
  crypto_names = get_crypto_names(url_main_path)
  crypto_values = get_crypto_values(url_main_path)
  cryptocurrencies = Hash[crypto_names.zip(crypto_values)]
end

get_cryptocurrencies