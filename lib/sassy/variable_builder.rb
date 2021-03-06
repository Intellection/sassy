# -*- encoding : utf-8 -*-
module Sassy
  class VariableBuilder
    class << self
      def single(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id], :single)
        xml_builder.variable(:ident => variable[:id], :type => "single") do |v|
          #validate_name
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
          build_single_values(v, variable)
        end

        xml_builder
      end

      def quantity(xml_builder, variable, answer_positions)
        position_start, position_end, answers = calculate_position(answer_positions, variable[:id], :quantity)
        xml_builder.variable(ident: variable[:id], type: "quantity") do |v|
          #validate_name
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
          build_quantity_values(v, variable, answers)
        end

        xml_builder
      end

      def character(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id], :character)
        xml_builder.variable(ident: variable[:id], type: "character") do |v|
          #validate_name
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
          v.size(position_end.to_i - position_start.to_i)
        end

        xml_builder
      end

      private

      def build_single_values(xml_builder, variable)
        xml_builder.values do |va|
          raise ArgumentError, "Variable values need to start at 1 for valid Triple-S output" if invalid_values?(variable[:values].keys)

          variable[:values].each do |key, val|
            va.value(val, code: key)
          end
        end

        xml_builder
      end

      def invalid_values?(values)
        values.any? {|v| [0, "0"].include? v}
      end

      def build_quantity_values(xml_builder, variable, answers)
        xml_builder.values do |va|
          from, to = calculate_from_and_to(answers)
          if from.empty?
            va.value("No answer", code: 9999.99)
          else
            va.range(from: from, to: to)
          end
        end
 
        xml_builder
      end

      def calculate_position(answer_positions, variable_id, variable_type)
        # ugh, this nees to change to be name rather than position based
        if variable_type == :quantity
          answer_positions[variable_id - 1].values_at(:start, :finish, :answers)
        else
          answer_positions[variable_id - 1].values_at(:start, :finish)
        end
      end

      def validate_name(name)
        raise ArgumentError, ":name param must be in format ([a-zA-Z_])([a-zA-Z0-9_\\.])*" unless name =~ /([a-zA-Z_])([a-zA-Z0-9_\.])*/
        # could maybe do name.gsub("-","_") or some other kind of replacement, and fall back to
        # raising the exception if still doesn't pass
      end

      def calculate_from_and_to(answers)
        numeric_answers = answers.map(&:to_s).reject(&:empty?).map do |n| 
          n.include?('.') ? n.to_f : n.to_i
        end

        from, to = numeric_answers.min.to_s, numeric_answers.max.to_s
        return "" if from.empty? || to.empty?

        normalise_widths(from, to)
      end

      def normalise_widths(from, to)
        width = max_width(from, to)
        [from, to].tap do |values|
          values.each do |val|
            dec_points = capture_decimal_places(val)
            padded_dec_points = dec_points.ljust(width - dec_points.length, "0")
            val << "." unless val.include?(".")
            val << padded_dec_points if dec_points.length < width
          end
        end
      end

      def max_width(from, to)
        [capture_decimal_places(from).length, capture_decimal_places(to).length].max
      end

      def capture_decimal_places(value)
        value.include?(".") ? value.match(/(?:\.)(\d*)/).captures[0] : ""
      end
    end
  end
end
