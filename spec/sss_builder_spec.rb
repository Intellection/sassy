require 'spec_helper'

describe Sassy::SSSBuilder do

  context "Exporting an array of variables and answers" do
    before(:each) do
      questions = [{
          :id=>1,
          :name=>"Respondent_ID",
          :type=>"character",
          :label=>"ID",
          :values=>
          {
            "generated"=>"Generated"
          }
        },
        {
          :id=>2,
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
          :id=>3,
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
          :id=>4,
          :name=>"Q32",
          :type=>"quantity",
          :label=>"Years as loyal customer",
          :values=>
          {
            "range"=>
            {
              from: -9,
              to: 99
            }
          }
        },
        {
          :id=>5,
          :name=>"Q38",
          :type=>"quantity",
          :label=>"Time spent being foolish",
          :values=>
          {
            "range"=>
            {
              from: -9,
              to: 99
            }
          }
        }]

      answers = [
        { type: "character", qanswers: ["m09876543211", "27720628423", "27712345678"] },
        { type: "single", qanswers: [2, 1, 1] },
        { type: "single", qanswers: [3, 10, 6] },
        { type: "quantity", qanswers: ["14.285714285714285", 0, "2.123"]},
        { type: "quantity", qanswers: ["", "", ""]}
      ]

      Sassy.write_to_file! variables: questions, answers: answers
      @doc = Nokogiri::XML(File.open("definition_file.xml"))
    end

    after(:each) do
      File.delete("definition_file.xml") if File.exist?("definition_file.xml")
      File.delete("data_file.dat") if File.exist?("data_file.dat")
    end

    it "should contain an opening sss element" do
      @doc.xpath("//sss").should_not be_empty
    end

    it "the xml should be valid" do
      @doc.errors.should be_empty
    end

    it "should contain a version attribute" do
       @doc.xpath("//sss/@version")[0].value.should == "1.2"
    end

    it "should contain an opening survey element" do
      @doc.xpath("//survey").should_not be_empty
    end

    it "should contain a valid opening record element" do
      (@doc.xpath("//record")[0].attributes["ident"].value =~ /[a-zA-Z]/).nil?.should be_false
    end

    it "should contain an opening variable element" do
      @doc.xpath("//variable").should_not be_empty
    end

    context "when the element is a variable element" do

      it "there should be a type attribute" do
        @doc.xpath("//variable/@type")[0].value.should_not be_empty
      end

      it "there should be a valid ident attribute" do
        @doc.xpath("//variable/@ident")[0].value.should == "1"
      end

      it "all ident attributes are unique" do
        idents = @doc.xpath("//variable/@ident").map { |i| i.value }
        idents.uniq.length.should == 5
      end

      it "should contain a name element" do
        pending "Need to make sure that the regex is correct"
        valid_regex = "([a-zA-Z_])([a-zA-Z0-9_\.])*"
        @doc.xpath("//variable/name").length.should == 5
      end

      it "should contain a label element" do
        @doc.xpath("//variable/label").length.should == 5
      end

      it "should contain a position element" do
        @doc.xpath("//variable/position").length.should == 5
      end

      context "when the variable is type single" do
        it "should contain a values element" do
          @doc.xpath("//variable[@ident=2]//values").should_not be_empty
        end

        it "the start and finish attributes of the position element must be correct" do
          @doc.xpath("//variable")[1].at_xpath("position").attributes["start"].value.should == "13"
          @doc.xpath("//variable")[1].at_xpath("position").attributes["finish"].value.should == "13"
        end

        context "and the element is a values element" do
          it "should have a nested value element" do
            @doc.xpath("//variable[@ident=2]//values/value").should_not be_empty
          end

          it "the value element should have a code attribute" do
            @doc.xpath("//variable")[1].at_xpath("values").at_xpath("value").attributes["code"].value.should == "1"
          end

          it "the value element should have some content" do
            @doc.xpath("//variable")[1].at_xpath("values").at_xpath("value").children.text.should == "18-29"
          end

          it "the value of the code attribute must be legal" do
            code_ids = @doc.xpath("/sss/survey/record/variable[@ident=2]//value").map {|n| n["code"] }
            code_ids.uniq.length.should == 3
            code_ids.map{|e| e.scan(/^[-]?[0-9]*$/)}.flatten.length.should == 3
          end
        end
      end

      context "when the variable is type quantity" do
        it "should contain a range element" do
          @doc.xpath("/sss/survey/record/variable[@ident=4]//range").should_not be_empty
        end

        it "should have a value element when there is no data" do
          @doc.xpath("/sss/survey/record/variable[@ident=5]//value").should_not be_empty
        end

        it "the field width of the from and to fields should match the position_start and position_end width" do
          finish_attr = @doc.xpath("/sss/survey/record/variable[@ident=4]//position").attr("finish").value.to_i
          start_attr = @doc.xpath("/sss/survey/record/variable[@ident=4]//position").attr("start").value.to_i
          to = @doc.xpath("/sss/survey/record/variable[@ident=4]//range").attr("to").value.length
          from = @doc.xpath("/sss/survey/record/variable[@ident=4]//range").attr("from").value.length
          max_width = [from, to].max

          (finish_attr - start_attr + 1).should == max_width
        end

        it "the from and to fields should have the same width and decimal places" do
          to = @doc.xpath("/sss/survey/record/variable[@ident=4]//range").attr("to").value.length
          from = @doc.xpath("/sss/survey/record/variable[@ident=4]//range").attr("from").value.length
          (to.to_s.split('.').last.length == from.to_s.split('.').last.length).should be_true
        end

        it "the range element should have a from and to attribute" do
          @doc.xpath("/sss/survey/record/variable[@ident=4]//range/@from")[0].value.should == "0.000000000000000"
        end

        it "the values of the from and to attributes are legal" do
          @doc.xpath("/sss/survey/record/variable[@ident=4]//range/@from")[0].value.scan(/^[-]?\d+\.?\d*$/)[0].should ==
          "0.000000000000000"
          @doc.xpath("/sss/survey/record/variable[@ident=4]//range/@to")[0].value.scan(/^[-]?\d+\.?\d*$/)[0].should ==
          "14.285714285714285"
        end
      end

      context "when the variable is type character" do
        it "should contain a size element element" do
          @doc.xpath("/sss/survey/record/variable[@ident=1]//size").should_not be_empty
        end

        it "the content of the size element is legal" do
          # no + sign, no spaces, numeric digits must be present
          @doc.xpath("/sss/survey/record/variable[@ident=1]//size")[0].inner_text.should == "11"
        end
      end
    end
  end
end
