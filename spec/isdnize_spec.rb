require 'spec_helper'

describe NoPhone, "#msisdnize" do

  it "ignores nils" do
    NoPhoneWrapper.msisdnize(nil).should eq(nil)
  end

  it "ignores empty strings" do
    NoPhoneWrapper.msisdnize("").should eq(nil)
  end

  it "adds country code to naked norwegian-ish numbers" do
    NoPhoneWrapper.msisdnize("12345678").should eq("4712345678")
  end

  it "removes +sign from international number" do
    NoPhoneWrapper.msisdnize("+123456789").should eq("123456789")
  end
end

describe NoPhone, "#unmsisdnize" do
  it "localizes norwegian numbers" do
    NoPhoneWrapper.unmsisdnize("4712345678").should eq("12345678")
  end

  it "adds a + to international numbers" do
    NoPhoneWrapper.unmsisdnize("123456789").should eq("+123456789")
  end
end
