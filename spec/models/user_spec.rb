require 'rails_helper'

describe User do
  describe '#create' do

    it "nicknameとemailとpasswordがあれば登録できる" do 
      expect(create(:user)).to be_valid
    end 

    it "nicknameが空では登録できない" do 
      expect(build(:user, nickname: "")).to_not be_valid 
    end 

    it "emailが空では登録できない" do 
      expect(build(:user, email: "")).to_not be_valid 
    end 

    it "重複したemailが存在する場合登録できない" do 
      user1 = create(:user,nickname: "taro", email: "taro@example.com")
      expect(build(:user, nickname: "ziro", email: user1.email)).to_not be_valid
    end 

    it "passwordが空では登録できない" do 
      expect(build(:user, password: "")).to_not be_valid 
    end

    it "password_confirmationとpasswordが異なる場合保存できない" do 
      expect(build(:user,password:"0000000",password_confirmation: "0000001")).to_not be_valid 
    end

    it "passwordが6文字以下であれば登録できない" do
      expect(build(:user, password: "000000", password_confirmation: "000000")).to_not be_valid 
    end

  end
end