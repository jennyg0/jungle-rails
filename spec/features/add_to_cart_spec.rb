require 'rails_helper'

RSpec.feature "Visitor is able to add item to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

scenario "Adds to cart when clicked" do
  visit root_path
  expect(page).to have_text 'My Cart (0)'
  save_screenshot('3a.png')
  first(:button, "Add").click
  sleep(1)
  save_screenshot('3b.png')

  expect(page).to have_text 'My Cart (1)'
end
end