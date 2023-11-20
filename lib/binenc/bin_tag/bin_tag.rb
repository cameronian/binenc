
#require 'singleton'

module Binenc

  # binary tagging constant helper
  class BinTag
    include TR::CondUtils
    #include Singleton

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
        if not_empty?(key)
          ikey = key.to_s.downcase
          if @constant.keys.include?(ikey) 
            if @constRaiseIfDup
              raise BinTagConstantKeyAlreadyExist, "Constant key '#{key}' already exist"
            else
              logger.warn "Overwriting existing key '#{key}'..."
            end
          end

          if val.is_a?(String) and val =~ /#/
            val = val.gsub("#",@parent).strip
          end

          @constant[ikey] = val

          oldParent = @parent 

          @parent = val
          if block
            instance_eval(&block)
          end
          @parent = oldParent
        end

      end

      def constant_value(key)
        if not_empty?(key)
          #logger.debug "search key : #{key}"
          #logger.debug "Record : #{@constant}"
          @constant[key.to_s.downcase]
        end
        #@constant[key.to_s.downcase] if not_empty?(key)
      end

      # find constant from given value
      def value_constant(val)
        if val.is_a?(Integer)
          v = @constant.invert[val.to_s.to_i]
        else
          v = @constant.invert[val]
        end
        v.to_sym if not_empty?(v)
        #v if not_empty?(v)
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
