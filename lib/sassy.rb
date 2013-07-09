require "builder"
require "sassy/version"
require "sassy/sss_builder"
require "sassy/variable_builder"
require "sassy/answer_builder"

module Sassy

  # Variables need to be an array of hashes, while answers an array of arrays. 
  # Each variable must have a unique id starting from 0
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

  #
  # answers = [[col1],[col2], ..., [coln]]

  def self.write!(options)
    Sassy::SSSBuilder.new(options).write!
  end

end