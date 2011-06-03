require 'spec_helper'

describe NoPhone, "#msisdnize" do
  it "adds country code to naked norwegian-ish numbers" do
    NoPhone.msisdnize("12345678").should eq("4712345678")
  end

  it "removes +sign from international number" do
    NoPhone.msisdnize("+123456789").should eq("123456789")
  end
end

describe NoPhone, "#unmsisdnize" do
  it "localizes norwegian numbers" do
    NoPhone.unmsisdnize("4712345678").should eq("12345678")
  end

  it "adds a + to international numbers" do
    NoPhone.unmsisdnize("123456789").should eq("+123456789")
  end
end
