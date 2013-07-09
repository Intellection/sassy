require 'spec_helper'

describe Sassy::SSSBuilder do

  context "When given an array of questions" do
    before(:each) do
      questions = [{
          :id=>0,
          :name=>"Respondent_ID", 
          :type=>"character", 
          :label=>"ID", 
          :values=>
          {
            "generated"=>"Generated"
          }
        },  
        {
          :id=>1,
          :name=>"AGE_GROUP", 
          :type=>"single", 
          :label=>"Age group", 
          :values=>
          {
            "1"=>"18-29", 
            "2"=>"30-44", 
            "3"=>"45+"
          }
        }, 
        {
          :id=>2,
          :name=>"Q24", 
          :type=>"single", 
          :label=>"Favourite tourist attraction", 
          :values=>
          {
            "1"=>"The Waterfront", 
            "2"=>"Table Mountain", 
            "3"=>"Cape Point", 
            "4"=>"Whale spotting", 
            "5"=>"The Garden Route", 
            "6"=>"Township Tour", 
            "7"=>"Shark cage diving", 
            "8"=>"Wine tasting",
            "9"=>"Watch Bokke smash All Blacks",
            "10"=>"Robben Island"
          }
        },  
        {
          :id=>3,
          :name=>"Q32", 
          :type=>"quantity", 
          :label=>"Years as loyal customer", 
          :values=>
          {
            "range"=>"-9..99"
          }
        }]

      answers = [
        ["m09876543211", "27720628423", "27712345678"],
        [2, 1, 1],
        [3, 10, 6],
        [11, 3, -2]
      ]

      @xml = Sassy.write! variables: questions, answers: answers
    end

    after(:each) do
      File.delete("definition_file.xml")
      File.delete("data_file.dat")
    end

    it "should build the xml correctly" do
      doc = Nokogiri::XML(File.open("definition_file.xml"))
      variable_array = doc.xpath("//variable")
      puts @xml.inspect
    end

    it "should contain an opening sss element" do
    end

    it "should contain a closing sss element" do
    end

    it "should contain a version attribute" do
    end

    it "should contain an opening survey element" do
    end

    it "should contain a closing survey element" do
    end

    it "should contain an opening record element" do
    end

    it "should contain a closing record element" do
    end

    it "should contain an opening variable element" do
    end

    it "should contain a closing variable element" do
    end

    context "when the element is a variable element" do

      it "there should be a variable_type attribute" do
      end

      it "there should be an ident attribute" do
      end

      it "should contain a name element" do
      end

      it "should contain a label element" do
      end

      it "should contain a position element" do
      end

      context "when the variable is type single" do
        it "should contain a values element" do
        end

        it "the number of decimal values in a value attribute must match the data in data file" do
        end

        context "and the element is a values element" do
          it "should have a nested value element" do
          end

          it "the value element should have a code attribute" do
          end

          it "the value element should have some content"

          it "the value of the code attribute must be unique and positive" do
          end

          it "all the code values are legal" do
            # no + sign, no spaces, numeric digits must be present
          end
        end
      end

      context "when the variable is type quantity" do
        it "should contain a range element" do
        end

        it "the range element should have a from and to attribute" do
        end

        it "the values of the from and to attributes are legal" do
          # no + sign, no spaces, numeric digits must be present
        end
      end

      context "when the variable is type character" do
        it "should contain a size element element" do
        end

        it "the content of the size element is legal" do
          # no + sign, no spaces, numeric digits must be present
        end
      end
    end
  end
end