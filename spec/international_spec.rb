require 'spec_helper'

describe NorwegianPhone, "#international" do
  it "knows a norse number when it sees one" do
    NorwegianPhoneWrapper.international?("12345678").should == false
  end

  it "knows a norse number even when it looks international" do
    NorwegianPhoneWrapper.international?("+4712345678").should == false
  end

  it "correctly identifies a non-norwegian international number" do
    NorwegianPhoneWrapper.international?("+4612345678").should == true
  end
end
