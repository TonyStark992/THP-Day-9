require_relative '../lib/mairie_christmas.rb'

# Test si il y a bien le bon nombre de noms de mairies
describe "the get_townhall_names method" do
  it "should have the same number of names as there are townhalls" do
    expect(get_townhall_names.length).to be == 185
  end
end

# Test si le programme renvoie bien des données cohérentes
describe "get_email_address_books" do
  it "should return a hash of 185 emails" do
    expect(get_email_address_books).to be_an_instance_of(Hash)
    expect(get_email_address_books.length).to be == 185
  end
end