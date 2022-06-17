# frozen_string_literal: true

require 'teLogger'
require 'toolrack'

require_relative "binenc/version"

require_relative 'binenc/provider'

require_relative 'binenc/engine_factory'

require_relative 'binenc/binary_object'

require_relative 'binenc/bin_tag/bin_tag'


module Binenc
  class Error < StandardError; end

  class BinencEngineException < StandardError; end

  class BinTagException < StandardError; end
  class BinTagConstantKeyAlreadyExist < StandardError; end
  class BinTagConstantKeyNotFound < StandardError; end
  # Your code goes here...
end
