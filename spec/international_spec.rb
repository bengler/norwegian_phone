require 'spec_helper'

describe NoPhone, "#international" do
  it "knows a norse number when it sees one" do
    NoPhone.international?("12345678").should == false
  end

  it "knows a norse number even when it looks international" do
    NoPhone.international?("+4712345678").should == false
  end

  it "correctly identifies a non-norwegian international number" do
    NoPhone.international?("+4612345678").should == true
  end
end
