require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before :each do
      @category = Category.new(name: 'Home')
    end

    it 'saves successfully' do 
      @product = Product.new(name:'Candle', price: 80, quantity: 11, category: @category).save
      expect(@product).to eq(true)
    end

    it 'name must be present' do
      @product = Product.new(name: nil, price: 80, quantity: 11, category: @category)
      #expect(@product).to eq(false)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'price must be present' do
      @product = Product.new(name:'Candle', quantity: 5, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'quantity must be present' do
      @product = Product.new(name:'Candle', price: 80, quantity: nil, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'category must be present' do
      @product = Product.new(name:'Candle', price: 80, quantity: 11, category: nil)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
