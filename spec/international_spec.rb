require 'spec_helper'

describe NoPhone, "#international" do
  it "knows a norse number when it sees one" do
    NoPhoneWrapper.international?("12345678").should == false
  end

  it "knows a norse number even when it looks international" do
    NoPhoneWrapper.international?("+4712345678").should == false
  end

  it "correctly identifies a non-norwegian international number" do
    NoPhoneWrapper.international?("+4612345678").should == true
  end
end
