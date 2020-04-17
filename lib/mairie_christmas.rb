require 'pry'
require 'nokogiri'
require 'open-uri'

# Méthode qui récupère l’e-mail d'une mairie à partir de l'URL de mairie
def get_townhall_email (townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

# Méthode qui récupère les URLs de chaque ville du Val-d'Oise (95)
def get_townhall_urls
  page_val_d_oise = Nokogiri::HTML(open('http://www.annuaire-des-mairies.com/val-d-oise.html'))
  urls = page_val_d_oise.xpath('/html/body/table/tr[3]/td/table/tr/td[2]//a[contains(@href,"/95/")]')
  urls = urls.map {|link| link["href"]}
  urls = urls.map {|url| url.gsub("./95/", "https://www.annuaire-des-mairies.com/95/")}
end

# Méthode qui récupère les adresses emails à partir des URLs des mairies
def get_townhall_emails (urls)
  emails = Array.new
  urls.each do |url|
    emails << get_townhall_email(url)
  end
  emails
end

# Méthode qui récupère les noms des mairies
def get_townhall_names
  page_val_d_oise = Nokogiri::HTML(open('http://www.annuaire-des-mairies.com/val-d-oise.html'))
  names = page_val_d_oise.xpath('/html/body/table/tr[3]/td/table/tr/td[2]//a[contains(@href,"/95/")]')
  names = names.map {|name| name.text}
end

# Méthode principale qui renvoie un hash avec les mairies et leurs emails
def get_email_address_books
  names = get_townhall_names
  emails = get_townhall_emails(get_townhall_urls)
  email_address_books = Hash[names.zip(emails)]
end

get_email_address_books