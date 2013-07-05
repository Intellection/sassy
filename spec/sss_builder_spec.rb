require 'spec_helper'

describe Sassy::SSSBuilder do
  context "given an array of questions" do

    # need to ensure that either after each test or failure/finish the files get deleted
    
    before(:each) do
      
    end

    context "a single variable" do
      before(:each) do
        foo = Sassy::SSSBuilder.new(TEST_QUESTIONS)  
      end
      it "the variable should have a return type of single and ident attribute of 1" do
      end

      it "should have a name of Q1" do
      end

      it "should have a label of 'Number of visits'" do
      end

      it "should have a position tag with attribute start of 1 and no finish attribute" do
      end

      it "should have a values tag with 3 nested value tags" do
      end

      it "the second value tag should have a code attribute of 2 and contain 'Visited before within the year'" do
      end
    end

    context "a character variable" do
      it "should have a variable tag with an ident attribute of 3 and type attribute of character" do
      end

      it "should have a name tag containing Q3" do
      end

      it "should have a label tag containing Other attractions visited" do
      end

      it "should have a position tag with start attribute of 11 and finish attribute of 40" do
      end

      it "should have a size tag containing 30" do
      end
    end

    context "a quantity variable" do
      it "should contain a variable tag with ident attribute 99 and type attribute quantity" do
      end

      it "should have a name tag containing Q99" do
      end

      it "should have a label tag containing Case weight" do
      end

      it "should have a position tag with start attribute of 48 and finish attribute of 54" do
      end

      it "should have a range tag with from attribute 0.0000 and to attribute of 99.9999" do
      end
    end
  end
end