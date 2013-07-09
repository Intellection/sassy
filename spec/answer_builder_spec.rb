require 'spec_helper'

describe Sassy::AnswerBuilder do

  context "given an array of arrays of answers" do

    # columns
    let(:answers_array) {[["m09876543211", "27720628423", "27712345678"],[2, 1, 1],[3, 10, 6],[11, 3, -2]]}

    before(:each) do
      Sassy::AnswerBuilder.new(answers_array).create_data_file!("test.dat")
      @file = File.open("test.dat", "r")
    end

    after(:each) do
      @file.close
      File.delete("test.dat")
    end

    it "should write a file" do
      @file.read.should_not be_empty
    end

    it "a record terminator should exist" do
      @file.readline.chomp.should_not be_nil
    end

    it "there should only be 3 lines in the file" do
      @file.readlines.count.should == 3
    end

    context "the single variable answers" do
      it "should be right justified and padded" do
        @file.readline[13..14].should == " 3"
      end
    end

    context "the quantity variable answers" do
      it "should be right justified and padded" do
        @file.readline
        @file.readline[15..16].should == " 3"
      end

      it "should be correctly formatted when dealing with negative values" do
        @file.readline
        @file.readline
        @file.readline[15..16].should == "-2"
      end
    end

    context "the character variable answers" do
      it "should be left justified and padded" do
        @file.readline
        @file.readline.chars.first(12).inject(&:<<).should == "27720628423 "
      end
    end
  end
end