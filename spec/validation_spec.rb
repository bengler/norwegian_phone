require 'spec_helper'

describe NorwegianPhone, "#number_valid?" do
  it "is invalid if nil" do
    NorwegianPhoneWrapper.number_valid?(nil).should be_false
  end

  it "is invalid if blank" do
    NorwegianPhoneWrapper.number_valid?("").should be_false
  end

  it "is invalid with letters" do
    NorwegianPhoneWrapper.number_valid?("1abc2").should be_false
  end

  context "with funky characters" do
    it "rejects parens" do
      NorwegianPhoneWrapper.number_valid?("123(45)678").should be_false
    end

    it "rejects hyphens" do
      NorwegianPhoneWrapper.number_valid?("123-45-678").should be_false
    end

    it "rejects periods" do
      NorwegianPhoneWrapper.number_valid?("123.45.678").should be_false
    end

    it "rejects +sign in the middle" do
      NorwegianPhoneWrapper.number_valid?("123+45+678").should be_false
    end

    it "accepts spaces" do
      NorwegianPhoneWrapper.number_valid?("123 45 678").should be_true
    end

    it "accepts +sign in the beginning" do
      NorwegianPhoneWrapper.number_valid?("+123 45 678").should be_true
    end
  end
end
