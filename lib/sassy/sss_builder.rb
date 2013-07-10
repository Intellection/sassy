require "benchmark"

module Sassy
  class SSSBuilder

    def initialize(options={})
      @survey_name = options.fetch(:survey_name, "Survey")
      @record_id = options.fetch(:record_id, "12345") # not sure what this should be
      @definition_file_name = options.fetch(:definition_file_name, "definition_file.xml")
      @data_file_name = options.fetch(:data_file_name, "data_file.dat")
      @variables = options[:variables]
      @answers = options[:answers]

      raise ArgumentError, "Required option missing: variables" if @variables.nil?
      raise ArgumentError, "Required option missing: answers" if @answers.nil?
    end

    def write!
      create_definition_file
      create_data_file
    end

    def create_data_file
      Sassy::AnswerBuilder.new(@answers).create_data_file! @data_file_name
    end

    def create_definition_file
      xml = Sassy::DefinitionBuilder.new(@variables, @survey_name, @record_id, @answers).build_sss_template
      File.open(@definition_file_name, "w") { |file| file.write(xml) }
    end
  end
end