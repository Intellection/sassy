# -*- encoding : utf-8 -*-
module Sassy
  class AnswerPositions

    def initialize(answer_columns)
      @answer_columns = answer_columns
    end

    def build
      # REFACTOR
      positions = []
      position_counter = 1
      @answer_columns.each do |column|
        max_length = column.map { |c| c.to_s.strip.length }.max || 0
        new_position = position_counter + max_length
        end_position = max_length == 1 ? position_counter : position_counter + max_length - 1
        positions << { start: position_counter, length: max_length, finish: end_position, answers: column }
        position_counter = new_position
      end
      positions
    end
  end
end
