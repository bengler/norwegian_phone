require 'spec_helper'

describe NoPhone, "#valid?" do
  it "is invalid if nil" do
    NoPhoneWrapper.valid?(nil).should be_false
  end

  it "is invalid if blank" do
    NoPhoneWrapper.valid?("").should be_false
  end

  it "is invalid with letters" do
    NoPhoneWrapper.valid?("1abc2").should be_false
  end

  context "with funky characters" do
    it "rejects parens" do
      NoPhoneWrapper.valid?("123(45)678").should be_false
    end

    it "rejects hyphens" do
      NoPhoneWrapper.valid?("123-45-678").should be_false
    end

    it "rejects periods" do
      NoPhoneWrapper.valid?("123.45.678").should be_false
    end

    it "rejects +sign in the middle" do
      NoPhoneWrapper.valid?("123+45+678").should be_false
    end

    it "accepts spaces" do
      NoPhoneWrapper.valid?("123 45 678").should be_true
    end

    it "accepts +sign in the beginning" do
      NoPhoneWrapper.valid?("+123 45 678").should be_true
    end
  end
end
