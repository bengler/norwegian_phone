require 'spec_helper'

describe NoPhone, "#number_valid?" do
  it "is invalid if nil" do
    NoPhoneWrapper.number_valid?(nil).should be_false
  end

  it "is invalid if blank" do
    NoPhoneWrapper.number_valid?("").should be_false
  end

  it "is invalid with letters" do
    NoPhoneWrapper.number_valid?("1abc2").should be_false
  end

  context "with funky characters" do
    it "rejects parens" do
      NoPhoneWrapper.number_valid?("123(45)678").should be_false
    end

    it "rejects hyphens" do
      NoPhoneWrapper.number_valid?("123-45-678").should be_false
    end

    it "rejects periods" do
      NoPhoneWrapper.number_valid?("123.45.678").should be_false
    end

    it "rejects +sign in the middle" do
      NoPhoneWrapper.number_valid?("123+45+678").should be_false
    end

    it "accepts spaces" do
      NoPhoneWrapper.number_valid?("123 45 678").should be_true
    end

    it "accepts +sign in the beginning" do
      NoPhoneWrapper.number_valid?("+123 45 678").should be_true
    end
  end
end
