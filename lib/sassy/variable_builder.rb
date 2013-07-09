module Sassy
  class VariableBuilder
    # REFACTOR! (inheritance or composition). Take away static methods as well.
    class << self
      def single(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(:ident => variable[:id], :type => "single") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          build_position_tag(v, variable, answer_positions)
          build_single_values(v, variable)
        end

        xml_builder
      end

      def quantity(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(ident: variable[:id], type: "quantity") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          build_position_tag(v, variable, answer_positions)
          v.range(from: variable[:values]["range"], to: variable[:values]["range"]) 
        end

        xml_builder
      end

      def character(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(ident: variable[:id], type: "character") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          build_position_tag(v, variable, answer_positions)
          v.size(30)
        end

        xml_builder
      end

      private

      def build_single_values(xml_builder, variable)
        # fix terrible naming
        xml_builder.values do |va| 
          variable[:values].each do |key, val|
            va.value(val, code: key)
          end
        end

        xml_builder
      end

      def build_position_tag(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable)
        position_start == position_end ? xml_builder.position(start: position_start) : xml_builder.position(start: position_start, finish: position_end) 
      end

      def calculate_position(answer_positions, variable_id)
        # answer_positions = [{start: 0, length: 12}, {start: 12, length: 1}, {start: 13, length: 1}, {start: 14, length: 1}, {start: 15, length: 4}, {start: 19, length: 1}]
        # OR
        # answer_positions = [12, 1, 1, 1, 4, 1] 
        # if questions started from 0-n, then can match question to position in answer_width array using index

        # answer_width hash way
        hsh = answer_positions[variable_id]
        [hsh[:start], hsh[:length] + hsh[:start]]

        # OR

        # answer_width flat array way
        # find width for that question.
        # to find starting position, need to add up all the previous widths - 1
        position_start = answer_positions.first(answer_positions[variable_id] + 1).inject(&:+) - 1
        [position_start, position_start + answer_positions[variable_id]]
      end
    end
  end
end