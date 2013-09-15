module Sassy
  class AnswerBuilder

    def initialize(answers)
      # need to do some validation on these answers
      @answers = answers
    end

    def write_to_file(file_name)
      File.open(file_name, "w") do |file|
        padded_answers.transpose.each do |row|
          file.puts(row.inject(&:<<))
        end
      end
    end

    def write(io)
      io.tap do |io|
        padded_answers.transpose.each do |row|
          io << row.inject(&:<<)
          io << "\n"
        end
      end
    end

    def self.answer_positions(answers)
      Sassy::AnswerPositions.new(answers.map{|a| a[:qanswers]}).build
    end

    private

    def padded_answers
      @answers.each_with_object([]) do |answer_hash, arr|
        length = answer_hash[:qanswers].map { |c| c.to_s.strip.length }.max
        if answer_hash[:type] == "character"
          arr << answer_hash[:qanswers].map { |a| a.to_s.ljust(length)}
        else
          arr << answer_hash[:qanswers].map { |a| a.to_s.rjust(length)}
        end
      end
    end
  end
end