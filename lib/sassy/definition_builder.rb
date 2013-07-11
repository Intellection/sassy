module Sassy
  class DefinitionBuilder

    def initialize(options)
      @variables = options[:variables]
      @answers = options[:answers]
      @survey_name = options.fetch(:survey_name, "Survey")
      @record_id = options.fetch(:record_id, "12345")
    end

    def write_to_file
      xml_builder = Builder::XmlMarkup.new(indent: 2)
      xml_builder.instruct!(:xml, :version=> "1.0", :encoding => "UTF-8")

      xml_builder.sss(version: 1.2) do |x|
        x.date(Date.today.strftime("%d %b, %Y"))
        x.time(Time.now.strftime("%H:%M"))
        build_survey(x)
      end

      xml_builder.target!
    end

    def write(io)
      xml_builder = Builder::XmlMarkup.new(target: io, indent: 2)
      xml_builder.instruct!(:xml, :version=> "1.0", :encoding => "UTF-8")

      xml_builder.sss(version: 1.2) do |x|
        x.date(Date.today.strftime("%d %b, %Y"))
        x.time(Time.now.strftime("%H:%M"))
        build_survey(x)
      end

      xml_builder.target!
    end

    private

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
          case variable[:type]
          when "quantity"
            Sassy::VariableBuilder.quantity(r, variable, answer_positions)
          when "single"
            Sassy::VariableBuilder.single(r, variable, answer_positions)
          when "character" 
            Sassy::VariableBuilder.character(r, variable, answer_positions)
          else
            raise "Unsupported type found. Please ensure that all variable types are one of the following: quantity, single, or character"
          end
        end
      end

      xml_builder
    end

    def answer_positions
      Sassy::AnswerBuilder.answer_positions(@answers)
    end
  end
end