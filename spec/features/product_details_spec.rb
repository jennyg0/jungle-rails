require 'rails_helper'

RSpec.feature "Visitor navigates to product detail from home page", type: :feature, js: true do

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

scenario "They go to details" do
  visit root_path
  
  save_screenshot('2a.png')
  first(:link, "Details").click
  sleep(1)
  save_screenshot('2b.png')

  expect(page).to have_css '.products-show', count: 1
end
end