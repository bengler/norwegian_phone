require 'spec_helper'

describe NoPhone, "#normalize" do
  context "Norwegian numbers" do
    let(:number) { "12345678" }

    context "with country code" do
      it "deletes prepended country code (47)" do
        NoPhone.normalize("4712345678").should == number
      end

      it "deletes prepended 0047" do
        NoPhone.normalize("004712345678").should == number
      end

      it "deletes prepended +47" do
        NoPhone.normalize("+4712345678").should == number
      end

      it "leaves extra digits intact" do
        NoPhone.normalize("+47123456789").should == "#{number}9"
      end

      it "removes extraneous prepended +signs" do
        NoPhone.normalize("++4712345678").should == number
      end

      it "strips interspersed +signs" do
        NoPhone.normalize("+47123+45+678").should == number
      end
    end

    context "without country code" do
      it "leaves extra digits intact" do
        NoPhone.normalize("123456789").should == "#{number}9"
      end
    end

    it "strips extraneous surrounding whitespace" do
      NoPhone.normalize("\t\n  \r\n12345678  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NoPhone.normalize("12    345 67 8").should == number
    end

    it "strips dashes" do
      NoPhone.normalize("12-34-56-78").should == number
    end

    it "strips periods" do
      NoPhone.normalize("12.34.56.78").should == number
    end

    it "strips parentheses" do
      NoPhone.normalize("(123)45678").should == number
    end


  end

  context "International numbers" do
    let(:number) { "+123456789" }

    it "replaces 0 with +" do
      NoPhone.normalize("0123456789").should == number
    end

    it "replaces 00 with +" do
      NoPhone.normalize("00123456789").should == number
    end

    it "leaves + alone" do
      NoPhone.normalize("+123456789").should == number
    end

    it "strips extraneous +signs" do
      NoPhone.normalize("++123456789").should == number
    end

    it "strips extraneous surrounding whitespace" do
      NoPhone.normalize("\t\n  \r\n+123456789  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NoPhone.normalize("+12    345 67 89").should == number
    end

    it "strips dashes" do
      NoPhone.normalize("+12-34-56-789").should == number
    end

    it "strips periods" do
      NoPhone.normalize("+12.34.56.789").should == number
    end

    it "strips parentheses" do
      NoPhone.normalize("+(123)456789").should == number
    end
  end

end
