require "benchmark"

module Sassy
  class SSSBuilder

    def initialize(options={})
      @survey_name = options.fetch(:survey_name, "Survey")
      @record_id = options[:record_id]
      @variables = options[:variables]
      @answers = options[:answers]

      raise ArgumentError, "Required option missing: record_id" if @record_id.nil?
      raise ArgumentError, "Required option missing: variables" if @variables.nil?
      raise ArgumentError, "Required option missing: answers" if @answers.nil?
    end

    def write!
      # not sure if I like exception handling for control flow
      begin
        create_definition_file(variables)
        #create_data_file(answers)
      rescue
        # some useful kind of exception here
      end
    end

    def create_definition_file
      xml = build_sss_template
      File.open("definition_file.xml", "w+") { |file| file.write(xml) } # What should this method return? Leaving w+ for now
    end

    def build_sss_template
      $KCODE = 'UTF8'
      xml_builder = Builder::XmlMarkup.new(indent: 2)
      xml_builder.instruct!(:xml, :version=> "1.0", :encoding => "UTF-8")

      xml_builder.sss(version: 1.2) do |x| # build_sss
        x.date(Date.today.strftime("%d %b, %Y"))
        x.time(Time.now.strftime("%H:%M"))
        build_survey(x)
      end

      xml_builder.target!
    end

    def build_survey(xml_builder)
      xml_builder.survey do |s|
        s.name(@survey_name)
        build_record(s)
      end

      xml_builder
    end

    def build_record(xml_builder)
      xml_builder.record(ident: @record_id) do |r|
        @variables.each do |variable|
          Sassy::VariableBuilder.single(r, variable)
          Sassy::VariableBuilder.character(r, variable)
          Sassy::VariableBuilder.quantity(r, variable)
        end
      end

      xml_builder
    end

    # def self.foo(xml_builder, variables)
    #   xml_builder.record(ident: 5) do |r|
    #     variables.each do |variable|
    #       Sassy::VariableBuilder.single(r, variable)
    #       Sassy::VariableBuilder.character(r, variable)
    #       Sassy::VariableBuilder.quantity(r, variable)
    #     end
    #   end

    #   xml_builder
    # end
  end
end