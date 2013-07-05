require "sassy/version"
require "sassy/sss_builder"
require "sassy/variable_builder"

module Sassy

  # Both variables and answers need to be an array of hashes
  # Below is a template for the required input:

  # variables = [{
  #   :name=>"name", 
  #   :type=>"single", 
  #   :label=>"label", 
  #   :values=>
  #   {
  #     "tag"=>"value"
  #   }
  # }]

  # TODO:
  #
  # answers = [{
  #
  # }]

  def self.write_to_file(variables, answers)
    Sassy::SSSBuilder.new(variables, answers).write!
  end

end