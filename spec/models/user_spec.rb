require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'saves successfully' do 
      @user = User.new(name:'Username', email: "test@test.com", password: "password", password_confirmation: "password").save
      expect(@user).to eq(true)
    end
    
    it 'passwords match' do
      @user = User.new(name:'Username', email: "test@test.com", password: "password", password_confirmation: "password2")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'emails must be unique' do
      @user1 = User.new(name:'Username', email: "test@test.com", password: "password", password_confirmation: "password").save
      @user2 = User.new(name:'Username2', email: "test@test.com", password: "12345678", password_confirmation: "12345678")
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'email should be present' do 
      @user = User.new(name:'Username', email: nil, password: "password", password_confirmation: "password")
      #expect(@user).to eq(false)
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'name should be present' do 
      @user = User.new(name:nil, email: "test@test.com", password: "password", password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'password should be present' do 
      @user = User.new(name:'Username', email: "test@test.com", password: nil, password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password confirmation should be present' do 
      @user = User.new(name:'Username', email: "test@test.com", password: "password", password_confirmation: nil)
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'password must be at least 8 characters' do 
      @user = User.new(name:'Username', email: "test@test.com", password: "pass", password_confirmation: "pass")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.new(name:'Username', email: "test@test.com", password: "password", password_confirmation: "password")
      @user.save
    end

    it 'logs in succesfully with correct information' do 
      @test_user = User.authenticate_with_credentials("test@test.com", "password")
      expect(@test_user).to be_eql(@user)
    end

    it 'email should not be case sensitive' do 
      @test_user = User.authenticate_with_credentials("tEsT@teSt.CoM", "password")
      expect(@test_user).to be_eql(@user)
    end

    it 'should not login if password wrong' do 
      @test_user = User.authenticate_with_credentials("test@test.com", "password2")
      expect(@test_user).to be_nil
    end

    it 'should login if spaces before email' do 
      @test_user = User.authenticate_with_credentials("    test@test.com", "password")
      expect(@test_user).to be_eql(@user)
    end

  end

  
end
