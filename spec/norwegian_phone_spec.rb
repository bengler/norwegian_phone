require 'spec_helper'

describe NorwegianPhone do

  context "is valid" do

    specify "with spaces" do
      NorwegianPhone.number_valid?("123 45 678").should be_true
    end

    specify "with +sign in the beginning" do
      NorwegianPhone.number_valid?("+123 45 678").should be_true
    end

  end

  context "is invalid" do

    specify "when nil" do
      NorwegianPhone.number_valid?(nil).should be_false
    end

    specify "when blank" do
      NorwegianPhone.number_valid?("").should be_false
    end

    specify "with letters" do
      NorwegianPhone.number_valid?("1abc2").should be_false
    end

    specify "with parens" do
      NorwegianPhone.number_valid?("123(45)678").should be_false
    end

    specify "with hyphens" do
      NorwegianPhone.number_valid?("123-45-678").should be_false
    end

    specify "with periods" do
      NorwegianPhone.number_valid?("123.45.678").should be_false
    end

    specify "with +sign in the middle" do
      NorwegianPhone.number_valid?("123+45+678").should be_false
    end
  end

  describe "normalization" do
    let(:number) { "12345678" }

    it "strips dashes" do
      NorwegianPhone.normalize("12-34-56-78").should == number
    end

    it "strips periods" do
      NorwegianPhone.normalize("12.34.56.78").should == number
    end

    it "strips parentheses" do
      NorwegianPhone.normalize("(123)45678").should == number
    end

    it "strips extraneous whitespace" do
      NorwegianPhone.normalize("\t\n  \r\n12 345  67 8  \t\r\n\n  ").should == number
    end

    it "leaves extra digits intact" do
      NorwegianPhone.normalize("123456789").should == "#{number}9"
    end

    it "removes extraneous prepended +signs" do
      NorwegianPhone.normalize("++12345678").should == "+#{number}"
    end

  end

  context "domestic normalization" do
    let(:number) { "12345678" }

    it "strips prepended 0047" do
      NorwegianPhone.normalize("004712345678").should == number
    end

    it "strips prepended +47" do
      NorwegianPhone.normalize("+4712345678").should == number
    end

    it "does not delete prepended country code (47)" do
      NorwegianPhone.normalize("4712345678").should == '4712345678'
    end
  end

  context "international normalization" do
    let(:number) { "+123456789" }

    it "replaces 0 with +" do
      NorwegianPhone.normalize("0123456789").should == number
    end

    it "replaces 00 with +" do
      NorwegianPhone.normalize("00123456789").should == number
    end

    it "leaves + alone" do
      NorwegianPhone.normalize("+123456789").should == number
    end

    it "strips extraneous +signs" do
      NorwegianPhone.normalize("++123456789").should == number
    end
  end

  describe "#msisdnize" do

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

  describe "#unmsisdnize" do
    it "localizes norwegian numbers" do
      NorwegianPhone.unmsisdnize("4712345678").should eq("12345678")
    end

    it "adds a + to international numbers" do
      NorwegianPhone.unmsisdnize("123456789").should eq("+123456789")
    end
  end

  describe "#international?" do
    it "knows a norse number when it sees one" do
      NorwegianPhone.international?("12345678").should == false
    end

    it "knows a norse number even when it looks international" do
      NorwegianPhone.international?("+4712345678").should == false
    end

    it "correctly identifies a non-norwegian international number" do
      NorwegianPhone.international?("+4612345678").should == true
    end
  end
end
