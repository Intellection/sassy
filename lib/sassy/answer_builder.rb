module Sassy
  class AnswerBuilder

    def initialize(answers)
      @answers = answers
    end

    def create_data_file!(file_name = "data_file.dat")
      # need to do some error checking here
      # what kind of errors?

      File.open(file_name, "w") do |file|
        padded_answers.transpose.each do |row|
          file.puts(row.inject(&:<<))
        end
      end
    end

    def self.answer_positions(answers)
      # method to calculate array/hash of answer widths
      # format:
      # [12, 1, 1, 1, 4, 1]
      # OR
      # [{start: 0, length: 12}, {start: 12, length: 1}, {start: 13, length: 1}, {start: 14, length: 1}, {start: 15, length: 4}, {start: 19, length: 1}]

      # answers.map do |column|
      #   column.map(&:strip).max_by{ |e| e.to_s.length }.to_s.length
      # end

      # OR

      # answers.map do |column|
      #   {
      #     start: 0,
      #     length: column.map(&:strip).max_by{ |e| e.to_s.length }.to_s.length
      #   }
      # end
    end

    private

    def padded_answers
      @answers.map do |column|
        length = column.max_by{ |e| e.to_s.strip.length }.to_s.length
        column.map do |answer|
          answer.to_s.rjust(length)
        end
      end
    end
  end
end