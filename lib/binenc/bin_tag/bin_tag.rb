
require 'singleton'

module Binenc

  # binary tagging constant helper
  class BinTag
    include TR::CondUtils
    include Singleton

      def initialize
        @constRaiseIfDup = false
        @constant = {  }
      end

      def load(&block)
        instance_eval(&block)
      end

      ## 
      # DSL part
      #
      def define_constant(key, val, parent = nil, &block)
        if @constant.keys.include?(key) 
          if @constRaiseIfDup
            raise BinTagConstantKeyAlreadyExist, "Constant key '#{key}' already exist"
          else
            logger.warn "Overwriting existing key '#{key}'..."
          end
        end

        if is_empty?(parent)
          @constant[key] = val
        else
          pa = @constant[parent]
          raise BinTagConstantKeyNotFound, "Parent key '#{parent}' not found" if is_empty?(pa)

          @constant[key] = "#{pa}#{val}"
        end
      end

      def constant_value(key)
        @constant[key]
      end

      def raise_on_constant_key_duplicate=(val)
        @constRaiseIfDup = val
      end
      def is_raise_on_constant_key_duplicate?
        @constRaiseIfDup
      end

      ## 
      # End DSL
      #

      private
      def logger
        if @logger.nil?
          @logger = TeLogger::Tlogger.new
          @logger.tag = :bintag
        end
        @logger
      end

  end

end
