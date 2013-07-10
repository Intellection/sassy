require "builder"
require "sassy/version"
require "sassy/sss_builder"
require "sassy/variable_builder"
require "sassy/answer_builder"
require "sassy/definition_builder"

module Sassy

  def self.export!(options)
    Sassy::SSSBuilder.new(options).write!
  end

end