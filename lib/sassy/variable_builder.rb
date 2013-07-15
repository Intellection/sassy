module Sassy
  class VariableBuilder
    class << self
      def single(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(:ident => variable[:id], :type => "single") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
          build_single_values(v, variable)
        end

        xml_builder
      end

      def quantity(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(ident: variable[:id], type: "quantity") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
          v.range(from: variable[:values]["range"][:from], to: variable[:values]["range"][:to])
        end

        xml_builder
      end

      def character(xml_builder, variable, answer_positions)
        position_start, position_end = calculate_position(answer_positions, variable[:id])
        xml_builder.variable(ident: variable[:id], type: "character") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: position_start, finish: position_end)
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

      def calculate_position(answer_positions, variable_id)
        # perhaps this should be based off name rather than id
        answer_positions[variable_id].values_at(:start, :finish)
      end
    end
  end
end