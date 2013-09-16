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
          variable[:values].each do |key, val|
            # may need to make sure that this starts at 1
            va.value(val, code: key)
          end
        end

        xml_builder
      end

      def build_quantity_values(xml_builder, variable, answers)
        from, to = calculate_min_and_max(answers)
        if from.nil? || to.nil?
          xml_builder.value("No answer", code: 9999.99)
        else
          xml_builder.range(from: from.round(1), to: to.round(1))
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
        raise ArgumentError, ":name param must be in format ([a-zA-Z_])([a-zA-Z0-9_\\.])*" unless name =~ /([a-zA-Z_])([a-zA-Z0-9_\\.])*/
        # could maybe do name.gsub("-","_") or some other kind of replacement, and fall back to
        # raising the exception if still doesn't pass
      end

      def calculate_min_and_max(answers)
        sanitized_answers = answers.map(&:to_s).reject(&:empty?).map(&:to_f)
        [sanitized_answers.min, sanitized_answers.max]
      end
    end
  end
end
