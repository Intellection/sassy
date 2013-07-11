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
      # REFACTOR
      positions = []
      position_counter = 1
      answers.each do |column|
        max_length = column.max_by{ |e| e.to_s.strip.length }.to_s.length
        new_position = position_counter + max_length
        end_position = max_length == 1 ? position_counter : position_counter + max_length - 1
        positions << { start: position_counter, length: max_length, finish: end_position }
        position_counter = new_position
      end
      positions
    end

    private

    def padded_answers
      @answers.map do |column|
        length = column.map { |c| c.to_s.strip.length }.max
        column.map do |answer|
          # if character, need to ljust
          answer.to_s.rjust(length)
        end
      end
    end
  end
end