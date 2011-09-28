require 'spec_helper'

describe NorwegianPhone, "#number_valid?" do
  it "is invalid if nil" do
    NorwegianPhone.number_valid?(nil).should be_false
  end

  it "is invalid if blank" do
    NorwegianPhone.number_valid?("").should be_false
  end

  it "is invalid with letters" do
    NorwegianPhone.number_valid?("1abc2").should be_false
  end

  context "with funky characters" do
    it "rejects parens" do
      NorwegianPhone.number_valid?("123(45)678").should be_false
    end

    it "rejects hyphens" do
      NorwegianPhone.number_valid?("123-45-678").should be_false
    end

    it "rejects periods" do
      NorwegianPhone.number_valid?("123.45.678").should be_false
    end

    it "rejects +sign in the middle" do
      NorwegianPhone.number_valid?("123+45+678").should be_false
    end

    it "accepts spaces" do
      NorwegianPhone.number_valid?("123 45 678").should be_true
    end

    it "accepts +sign in the beginning" do
      NorwegianPhone.number_valid?("+123 45 678").should be_true
    end
  end
end
