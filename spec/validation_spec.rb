require 'spec_helper'

describe NoPhone, "#valid?" do
  it "is invalid if nil" do
    NoPhone.valid?(nil).should be_false
  end

  it "is invalid if blank" do
    NoPhone.valid?("").should be_false
  end

  it "is invalid with letters" do
    NoPhone.valid?("1abc2").should be_false
  end

  context "with funky characters" do
    it "rejects parens" do
      NoPhone.valid?("123(45)678").should be_false
    end

    it "rejects hyphens" do
      NoPhone.valid?("123-45-678").should be_false
    end

    it "rejects periods" do
      NoPhone.valid?("123.45.678").should be_false
    end

    it "rejects +sign in the middle" do
      NoPhone.valid?("123+45+678").should be_false
    end

    it "accepts spaces" do
      NoPhone.valid?("123 45 678").should be_true
    end

    it "accepts +sign in the beginning" do
      NoPhone.valid?("+123 45 678").should be_true
    end
  end
end
