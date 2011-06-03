require 'spec_helper'

describe NoPhone, "#normalize" do
  context "Norwegian numbers" do
    let(:number) { "12345678" }

    context "with country code" do
      it "deletes prepended country code (47)" do
        NoPhoneWrapper.normalize("4712345678").should == number
      end

      it "deletes prepended 0047" do
        NoPhoneWrapper.normalize("004712345678").should == number
      end

      it "deletes prepended +47" do
        NoPhoneWrapper.normalize("+4712345678").should == number
      end

      it "leaves extra digits intact" do
        NoPhoneWrapper.normalize("+47123456789").should == "#{number}9"
      end

      it "removes extraneous prepended +signs" do
        NoPhoneWrapper.normalize("++4712345678").should == number
      end

      it "strips interspersed +signs" do
        NoPhoneWrapper.normalize("+47123+45+678").should == number
      end
    end

    context "without country code" do
      it "leaves extra digits intact" do
        NoPhoneWrapper.normalize("123456789").should == "#{number}9"
      end
    end

    it "strips extraneous surrounding whitespace" do
      NoPhoneWrapper.normalize("\t\n  \r\n12345678  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NoPhoneWrapper.normalize("12    345 67 8").should == number
    end

    it "strips dashes" do
      NoPhoneWrapper.normalize("12-34-56-78").should == number
    end

    it "strips periods" do
      NoPhoneWrapper.normalize("12.34.56.78").should == number
    end

    it "strips parentheses" do
      NoPhoneWrapper.normalize("(123)45678").should == number
    end


  end

  context "International numbers" do
    let(:number) { "+123456789" }

    it "replaces 0 with +" do
      NoPhoneWrapper.normalize("0123456789").should == number
    end

    it "replaces 00 with +" do
      NoPhoneWrapper.normalize("00123456789").should == number
    end

    it "leaves + alone" do
      NoPhoneWrapper.normalize("+123456789").should == number
    end

    it "strips extraneous +signs" do
      NoPhoneWrapper.normalize("++123456789").should == number
    end

    it "strips extraneous surrounding whitespace" do
      NoPhoneWrapper.normalize("\t\n  \r\n+123456789  \t\r\n\n  ").should == number
    end

    it "strips all internal whitespace" do
      NoPhoneWrapper.normalize("+12    345 67 89").should == number
    end

    it "strips dashes" do
      NoPhoneWrapper.normalize("+12-34-56-789").should == number
    end

    it "strips periods" do
      NoPhoneWrapper.normalize("+12.34.56.789").should == number
    end

    it "strips parentheses" do
      NoPhoneWrapper.normalize("+(123)456789").should == number
    end
  end

end
