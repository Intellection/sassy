module Sassy
  class VariableBuilder
    # should probably subclass all of this out
    class << self
      def single(xml_builder, variable)
        xml_builder.variable(:ident => 5, :type => "single") do |v| 
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: "1")
          build_single_values(v, variable)
        end

        xml_builder
      end

      def quantity(xml_builder, variable)
        xml_builder.variable(ident: 5, type: "quantity") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: 48, finish: 54)
          v.range(from: variable[:values]["range"], to: variable[:values]["range"]) 
        end

        xml_builder
      end

      def character(xml_builder, variable)
        xml_builder.variable(ident: 5, type: "character") do |v|
          v.name(variable[:name])
          v.label(variable[:label])
          v.position(start: 11, finish: 40)
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
    end
  end
end