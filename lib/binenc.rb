# frozen_string_literal: true

require 'teLogger'
require 'toolrack'

require_relative "binenc/version"

require_relative 'binenc/provider'

require_relative 'binenc/engine_factory'

require_relative 'binenc/binary_object'


module Binenc
  class Error < StandardError; end

  class BinencEngineException < StandardError; end
  # Your code goes here...
end
