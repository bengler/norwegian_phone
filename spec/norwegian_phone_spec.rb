require 'spec_helper'

describe NorwegianPhone do

  context "is valid" do

    specify "with spaces" do
      expect(NorwegianPhone.number_valid?("123 45 678")).to be true
    end

    specify "with +sign in the beginning" do
      expect(NorwegianPhone.number_valid?("+123 45 678")).to be true
    end

  end

  context "is invalid" do

    specify "when nil" do
      expect(NorwegianPhone.number_valid?(nil)).to be false
    end

    specify "when blank" do
      expect(NorwegianPhone.number_valid?("")).to be false
    end

    specify "with letters" do
      expect(NorwegianPhone.number_valid?("1abc2")).to be false
    end

    specify "with parens" do
      expect(NorwegianPhone.number_valid?("123(45)678")).to be false
    end

    specify "with hyphens" do
      expect(NorwegianPhone.number_valid?("123-45-678")).to be false
    end

    specify "with periods" do
      expect(NorwegianPhone.number_valid?("123.45.678")).to be false
    end

    specify "with +sign in the middle" do
      expect(NorwegianPhone.number_valid?("123+45+678")).to be false
    end
  end

  describe "normalization" do
    let(:number) { "12345678" }

    it "strips dashes" do
      expect(NorwegianPhone.normalize("12-34-56-78")).to eq(number)
    end

    it "strips periods" do
      expect(NorwegianPhone.normalize("12.34.56.78")).to eq(number)
    end

    it "strips parentheses" do
      expect(NorwegianPhone.normalize("(123)45678")).to eq(number)
    end

    it "strips extraneous whitespace" do
      expect(NorwegianPhone.normalize("\t\n  \r\n12 345  67 8  \t\r\n\n  ")).to eq(number)
    end

    it "leaves extra digits intact" do
      expect(NorwegianPhone.normalize("123456789")).to eq("#{number}9")
    end

    it "removes extraneous prepended +signs" do
      expect(NorwegianPhone.normalize("++12345678")).to eq("+#{number}")
    end

  end

  context "domestic normalization" do
    let(:number) { "12345678" }

    it "strips prepended 0047" do
      expect(NorwegianPhone.normalize("004712345678")).to eq(number)
    end

    it "strips prepended +47" do
      expect(NorwegianPhone.normalize("+4712345678")).to eq(number)
    end

    it "does not delete prepended country code (47)" do
      expect(NorwegianPhone.normalize("4712345678")).to eq('4712345678')
    end
  end

  context "international normalization" do
    let(:number) { "+123456789" }

    it "replaces 0 with +" do
      expect(NorwegianPhone.normalize("0123456789")).to eq(number)
    end

    it "replaces 00 with +" do
      expect(NorwegianPhone.normalize("00123456789")).to eq(number)
    end

    it "leaves + alone" do
      expect(NorwegianPhone.normalize("+123456789")).to eq(number)
    end

    it "strips extraneous +signs" do
      expect(NorwegianPhone.normalize("++123456789")).to eq(number)
    end
  end

  describe "#msisdnize" do

    it "ignores nils" do
      expect(NorwegianPhone.msisdnize(nil)).to eq(nil)
    end

    it "ignores empty strings" do
     expect(NorwegianPhone.msisdnize("")).to eq(nil)
    end

    it "adds country code to naked norwegian-ish numbers" do
      expect(NorwegianPhone.msisdnize("12345678")).to eq("4712345678")
    end

    it "removes +sign from international number" do
      expect(NorwegianPhone.msisdnize("+123456789")).to eq("123456789")
    end
  end

  describe "#unmsisdnize" do
    it "localizes norwegian numbers" do
      expect(NorwegianPhone.unmsisdnize("4712345678")).to eq("12345678")
    end

    it "adds a + to international numbers" do
      expect(NorwegianPhone.unmsisdnize("123456789")).to eq("+123456789")
    end
  end

  describe "#international?" do
    it "knows a norse number when it sees one" do
      expect(NorwegianPhone.international?("12345678")).to be false
    end

    it "knows a norse number even when it looks international" do
      expect(NorwegianPhone.international?("+4712345678")).to be false
    end

    it "correctly identifies a non-norwegian international number" do
      expect(NorwegianPhone.international?("+4612345678")).to be true
    end
  end
end
