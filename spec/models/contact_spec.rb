require 'rails_helper'

RSpec.describe Contact, type: :model do

  context 'tag asssociation' do

    it 'should increment tags_count' do

    contact = Contact.new(lastname: 'Dujardin', firstname: 'Olivier')

    contact.tags << Tag.new(name: 'friend')

    contact.save

    expect(Tag.count).to eq(1)

    expect(contact.tags.count).to eq(1)

    end

  end

  it 'should persist a contact' do

    Contact.create(lastname: 'Dujardin', firstname: 'Olivier')

    expect(Contact.count).to eq(1)

  end

end
