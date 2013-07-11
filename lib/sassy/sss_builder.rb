require "benchmark"

module Sassy
  class SSSBuilder

    def initialize(options={})
      @options = options

      raise ArgumentError, "Required option missing: variables" if options[:variables].nil?
      raise ArgumentError, "Required option missing: answers" if options[:answers].nil?
    end

    def write_to_file!
      create_definition_file
      create_answers_file
    end

    def write_variables(io)
      Sassy::DefinitionBuilder.new(@options).write(io)
    end

    def write_answers(io)
      Sassy::AnswerBuilder.new(@options[:answers]).write(io)
    end

    def write_zip(def_file_name='definition_file.xml', answer_file_name='data_file.dat', io=nil)
      buffer = Zip::Archive.open_buffer(Zip::CREATE) do |ar|
        def_io = StringIO.new
        dat_io = StringIO.new
        Sassy::DefinitionBuilder.new(@options).write(def_io)
        Sassy::AnswerBuilder.new(@options[:answers]).write(dat_io)
        def_io.rewind
        dat_io.rewind
        ar.add_io(def_file_name, def_io);
        ar.add_io(answer_file_name, dat_io);
      end
      io ? io << buffer.gets : buffer
    end

    private

    def create_answers_file(file_name = "definition_file.xml")
      Sassy::AnswerBuilder.new(@options[:answers]).write_to_file(file_name)
    end

    def create_definition_file(file_name = "data_file.dat")
      xml = Sassy::DefinitionBuilder.new(@options).write_to_file
      File.open(file_name, "w") { |file| file.write(xml) }
    end
  end
end