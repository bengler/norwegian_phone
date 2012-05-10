require 'spec_helper'

describe NorwegianPhone, "#normalize" do
  context "Norwegian numbers" do
    let(:number) { "12345678" }

    context "with country code" do
      it "deletes prepended 0047" do
        NorwegianPhone.normalize("004712345678").should == number
      end

      it "deletes prepended +47" do
        NorwegianPhone.normalize("+4712345678").should == number
      end

      it "leaves extra digits intact" do
        NorwegianPhone.normalize("+47123456789").should == "#{number}9"
      end

      it "removes extraneous prepended +signs" do
        NorwegianPhone.normalize("++4712345678").should == number
      end

      it "strips interspersed +signs" do
        NorwegianPhone.normalize("+47123+45+678").should == number
      end
    end

    context "without country code" do
      it "does not delete prepended country code (47)" do
        NorwegianPhone.normalize("4712345678").should == '4712345678'
      end

      it "leaves extra digits intact" do
        NorwegianPhone.normalize("123456789").should == "#{number}9"
      end
    end

    it "strips extraneous surrounding whitespace" do
      NorwegianPhone.normalize("\t\n  \r\n12345678  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NorwegianPhone.normalize("12    345 67 8").should == number
    end

    it "strips dashes" do
      NorwegianPhone.normalize("12-34-56-78").should == number
    end

    it "strips periods" do
      NorwegianPhone.normalize("12.34.56.78").should == number
    end

    it "strips parentheses" do
      NorwegianPhone.normalize("(123)45678").should == number
    end


  end

  context "International numbers" do
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

    it "strips extraneous surrounding whitespace" do
      NorwegianPhone.normalize("\t\n  \r\n+123456789  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NorwegianPhone.normalize("+12    345 67 89").should == number
    end

    it "strips dashes" do
      NorwegianPhone.normalize("+12-34-56-789").should == number
    end

    it "strips periods" do
      NorwegianPhone.normalize("+12.34.56.789").should == number
    end

    it "strips parentheses" do
      NorwegianPhone.normalize("+(123)456789").should == number
    end
  end

end
