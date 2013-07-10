require 'spec_helper'

describe Sassy::VariableBuilder do
  context "given an array of questions" do

    # need to ensure that either after each test or failure/finish the files get deleted

    # must test that all variable ids are unique

    # context "a single variable" do
    #   before(:each) do
    #     single_variable = {
    #       :id=>0,
    #       :name=>"AGE_GROUP", 
    #       :type=>"single", 
    #       :label=>"Age group", 
    #       :values=>
    #       {
    #         "1"=>"18-29", 
    #         "2"=>"30-44", 
    #         "3"=>"45+"
    #       }
    #     }

    #     answer_array = [[2, 1, 3]]

    #     xml_builder = Builder::XmlMarkup.new(indent: 2)
    #     answers = Sassy::AnswerBuilder.answer_positions(answer_array.transpose)
    #     @xml = Sassy::VariableBuilder.single(xml_builder, single_variable, answers)
    #   end

    #   it "the xml should be in SSS format" do
    #     expected_output = %q{
    #       <variable ident="0" type="single">
    #         <name>AGE_GROUP</name>
    #         <label>Age group</label>
    #         <position start="1" finish="1"/>
    #         <values>
    #           <value code="1">18-29</value>
    #           <value code="2">30-44</value>
    #           <value code="3">45+</value>
    #         </values>
    #       </variable>
    #     }
    #   end

    #   it "finish integer must be >= start location" do
    #     pending
    #   end
    # end

    # context "a character variable" do
    #   it "should have a variable tag with an ident attribute of 3 and type attribute of character" do
    #   end
    # end

    # context "a quantity variable" do
    #   it "should contain a variable tag with ident attribute 99 and type attribute quantity" do
    #   end

    #   it "should have a name tag containing Q99" do
    #   end

    #   it "should have a label tag containing Case weight" do
    #   end

    #   it "should have a position tag with start attribute of 48 and finish attribute of 54" do
    #   end

    #   it "should have a range tag with from attribute 0.0000 and to attribute of 99.9999" do
    #   end
    # end
  end
end