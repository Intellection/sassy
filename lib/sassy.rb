require "builder"
# need to actually use the fork, not this gem
require "zipruby"
require "stringio"
require "date"
require "sassy/version"
require "sassy/sss_builder"
require "sassy/variable_builder"
require "sassy/answer_builder"
require "sassy/definition_builder"

# perhaps delete this module code here and just have requires, use SSSBuilder directly
module Sassy

  def self.write_to_file!(options)
    Sassy::SSSBuilder.new(options).write_to_file!
  end
end