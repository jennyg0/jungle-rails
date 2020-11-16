require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before :each do
      @category = Category.new(name: 'Home')
    end
    
    it 'passwords match' do
    end

    it 'emails must be unique' do
    end

    it 'email should be present' do 
    end

    it 'name should be present' do 
    end

    it 'password must be at least 8 characters' do 
    end

    describe '.authenticate_with_credentials' do
      # examples for this class method here
    end

  end
end
