User.destroy_all
puts "start of User seed"
User.create!(email: "admin@admin.com", password: "adminadmin")
print "Users: "
p User.all
puts "End of User seed"

Contact.destroy_all
puts "start of contact seed"

tags_names = ['Loisir', 'Club tennis', 'Famille', 'Amis', 'Collègues', 'Anciens collègues',
  'Cours anglais', 'Médecin', 'Banque', 'Conférence IT 2018', 'Camarade de promo',
  'Achat', 'Vente', 'Vacance'
]

Tag.destroy_all
puts "start of Tag seed"
tags_names.each { |tag| Tag.create!(name: tag) }
print "Tags: "
p Tag.all
puts "End of Tag seed"

Contact.destroy_all
puts "start of contact seed"

Faker::Config.locale = 'fr'
255.times do

  fn = Faker::Name.first_name
  ln = Faker::Name.last_name
  # domain = Faker::Internet.domain_name
  street_address = Faker::Address.street_address
  zipcode = Faker::Address.zip_code()
  city = Faker::Address.city

  Contact.create!(
  firstname: fn,
  lastname: ln,
  address: "#{street_address}, #{zipcode} #{city}",
  email: "#{fn.parameterize}.#{ln.parameterize}@gmail.com",
  tel: Faker::PhoneNumber.phone_number
    )
end
print "contacts: "
p Contact.all
puts "End of contact seed"

Tagging.destroy_all
puts "start of Tagging seed"

number_of_tags = [0,1,2,3,4]

tags = Tag.all

Contact.all.each do |contact|
  n = number_of_tags.sample
  contact_tags = tags.sample(n)

  contact_tags.each do |tag|
    Tagging.create!(contact_id: contact.id, tag_id: tag.id)
  end

end

print "Taggings: "
p Tagging.all
puts "End of Tagging seed"
