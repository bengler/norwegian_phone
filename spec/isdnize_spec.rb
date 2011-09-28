require 'spec_helper'

describe NorwegianPhone, "#msisdnize" do

  it "ignores nils" do
    NorwegianPhone.msisdnize(nil).should eq(nil)
  end

  it "ignores empty strings" do
    NorwegianPhone.msisdnize("").should eq(nil)
  end

  it "adds country code to naked norwegian-ish numbers" do
    NorwegianPhone.msisdnize("12345678").should eq("4712345678")
  end

  it "removes +sign from international number" do
    NorwegianPhone.msisdnize("+123456789").should eq("123456789")
  end
end

describe NorwegianPhone, "#unmsisdnize" do
  it "localizes norwegian numbers" do
    NorwegianPhone.unmsisdnize("4712345678").should eq("12345678")
  end

  it "adds a + to international numbers" do
    NorwegianPhone.unmsisdnize("123456789").should eq("+123456789")
  end
end
